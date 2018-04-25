//
//  SecretTool.m
//  framework
//
//  Created by yoxnet on 16/4/18.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import "SecretTool.h"

// 填充模式
#define kTypeOfWrapPadding		kSecPaddingPKCS1
#define MAX_BLOCK_SIZE 117

#define kPublicKey  @"PublicKey"

@interface SecretTool ()

@property(nonatomic,assign)SecKeyRef publicKeyRef;                             // 公钥引用
@property(nonatomic,assign)SecKeyRef privateKeyRef;                            // 私钥引用

@property(nonatomic,assign)CFArrayRef identitys;


@end

@implementation SecretTool


-(SecIdentityRef)identity
{
    if(_identitys)
    {
        CFDictionaryRef dict = CFArrayGetValueAtIndex(_identitys, 0);
        
        return (SecIdentityRef)CFDictionaryGetValue(dict, kSecImportItemIdentity);
        
    }
    
    return NULL;
}

-(void)dealloc
{
    if (_publicKeyRef) {
        CFRelease(_publicKeyRef);
    }
    if (_privateKeyRef) {
        CFRelease(_privateKeyRef);
    }
    if (_identitys) {
        
        CFRelease(_identitys);
    }
    [self removePublicKey:kPublicKey];
}
+(instancetype)secretPublicKeyWithData:(NSData *)data;
{
    SecretTool * secret = [[SecretTool alloc] init];
    
    [secret loadPublicKeyWithData:data];
    
    return  secret;
}
//去头
- (NSData *)stripPublicKeyHeader:(NSData *)keyData
{
    // Skip ASN.1 public key header
    if (0 == [keyData length])
    {
        return nil;
    }
    
    unsigned char *keyBytes = (unsigned char *)[keyData bytes];
    unsigned int  index    = 0;
    
    if (keyBytes[index++] != 0x30) return nil;
    
    if (keyBytes[index] > 0x80) index += keyBytes[index] - 0x80 + 1;
    else index++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&keyBytes[index], seqiod, 15)) return nil;
    
    index += 15;
    
    if (keyBytes[index++] != 0x03) return nil;
    
    if (keyBytes[index] > 0x80) index += keyBytes[index] - 0x80 + 1;
    else index++;
    
    if (keyBytes[index++] != '\0') return nil;
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&keyBytes[index] length:[keyData length] - index]);
}

-(SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef
{
    OSStatus sanityCheck = noErr;
    SecKeyRef keyRef = NULL;
    
    //    LOGGING_FACILITY(persistentRef != NULL, @"persistentRef object cannot be NULL." );
    
    NSMutableDictionary * queryKey = [[NSMutableDictionary alloc] init];
    
    // Set the SecKeyRef query dictionary.
    [queryKey setObject:(__bridge id)persistentRef forKey:(__bridge id)kSecValuePersistentRef];
    [queryKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    
    // Get the persistent key reference.
    sanityCheck = SecItemCopyMatching((__bridge CFDictionaryRef)queryKey, (CFTypeRef *)&keyRef);
    
    return keyRef;
}


-(void)loadPublicKeyWithData:(NSData *)data
{
    // 删除当前公钥
    if (_publicKeyRef) CFRelease(_publicKeyRef);
    _publicKeyRef = nil;

    
    NSData *certificateData = [self stripPublicKeyHeader:data];
    

    _publicKeyRef = [self addPublicKey:kPublicKey keyBits:certificateData];
    

}
- (SecKeyRef)addPublicKey:(NSString *)keyName keyBits:(NSData *)publicKey
{
    [self removePublicKey:keyName];
    
    OSStatus sanityCheck = noErr;
    SecKeyRef peerKeyRef = NULL;
    CFTypeRef persistPeer = NULL;
    NSAssert( keyName != nil, @"Key name parameter is nil." );
    NSAssert( publicKey != nil, @"Public key parameter is nil." );
    
    NSData * keyTag = [[NSData alloc] initWithBytes:(const void *)[keyName UTF8String] length:[keyName length]];
    NSMutableDictionary * peerPublicKeyAttr = [[NSMutableDictionary alloc] init];
    
    [peerPublicKeyAttr setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [peerPublicKeyAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [peerPublicKeyAttr setObject:keyTag forKey:(__bridge id)kSecAttrApplicationTag];
    [peerPublicKeyAttr setObject:publicKey forKey:(__bridge id)kSecValueData];
    [peerPublicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
    
    sanityCheck = SecItemAdd((__bridge CFDictionaryRef) peerPublicKeyAttr, (CFTypeRef *)&persistPeer);
    
    //    LOGGING_FACILITY1( sanityCheck == noErr || sanityCheck == errSecDuplicateItem, @"Problem adding the app public key to the keychain, OSStatus == %ld.", sanityCheck );
    
    if (persistPeer)
    {
        peerKeyRef =[self getKeyRefWithPersistentKeyRef:persistPeer];
    }
    else
    {
        [peerPublicKeyAttr removeObjectForKey:(__bridge id)kSecValueData];
        [peerPublicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
        // Let's retry a different way.
        sanityCheck = SecItemCopyMatching((__bridge CFDictionaryRef) peerPublicKeyAttr, (CFTypeRef *)&peerKeyRef);
    }
    
    //    LOGGING_FACILITY1( sanityCheck == noErr && peerKeyRef != NULL, @"Problem acquiring reference to the public key, OSStatus == %ld.", sanityCheck );
    
    if (persistPeer)
        CFRelease(persistPeer);
    return peerKeyRef;
}
- (void)loadPublicKeyWithDERFilePath:(NSString *)filePath;
{
    NSAssert(filePath.length != 0, @"公钥路径为空");
    
    // 删除当前公钥
    if (_publicKeyRef) CFRelease(_publicKeyRef);
    
    // 从一个 DER 表示的证书创建一个证书对象
    NSData *certificateData = [NSData dataWithContentsOfFile:filePath];
    
    SecCertificateRef certificateRef = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)certificateData);
    NSAssert(certificateRef != NULL, @"公钥文件错误");
    
    // 返回一个默认 X509 策略的公钥对象，使用之后需要调用 CFRelease 释放
    SecPolicyRef policyRef = SecPolicyCreateBasicX509();
    // 包含信任管理信息的结构体
    SecTrustRef trustRef;
    
    // 基于证书和策略创建一个信任管理对象
    OSStatus status = SecTrustCreateWithCertificates(certificateRef, policyRef, &trustRef);
    NSAssert(status == errSecSuccess, @"创建信任管理对象失败");
    
    // 信任结果
    SecTrustResultType trustResult;
    // 评估指定证书和策略的信任管理是否有效
    status = SecTrustEvaluate(trustRef, &trustResult);
    NSAssert(status == errSecSuccess, @"信任评估失败");
    
    // 评估之后返回公钥子证书
    _publicKeyRef = SecTrustCopyPublicKey(trustRef);
    NSAssert(_publicKeyRef != NULL, @"公钥创建失败");
    
    if (certificateRef) CFRelease(certificateRef);
    if (policyRef) CFRelease(policyRef);
    if (trustRef) CFRelease(trustRef);

   
}
- (void)loadPrivateKey:(NSString *)filePath password:(NSString *)password;
{
    NSAssert(filePath.length != 0, @"私钥路径为空");
    
    // 删除当前私钥
    if (_privateKeyRef) CFRelease(_privateKeyRef);
    
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:filePath];
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    CFStringRef passwordRef = (__bridge CFStringRef)password;
    
    // 从 PKCS #12 证书中提取标示和证书
    SecIdentityRef myIdentity;
    SecTrustRef myTrust;
    const void *keys[] = {kSecImportExportPassphrase};
    const void *values[] = {passwordRef};
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    // 返回 PKCS #12 格式数据中的标示和证书
    OSStatus status = SecPKCS12Import(inPKCS12Data, optionsDictionary, &items);
    
    if (status == noErr) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
        myIdentity = (SecIdentityRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
        myTrust = (SecTrustRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
    }
    
    if (optionsDictionary) CFRelease(optionsDictionary);
    
    NSAssert(status == noErr, @"提取身份和信任失败");
    
    SecTrustResultType trustResult;
    // 评估指定证书和策略的信任管理是否有效
    status = SecTrustEvaluate(myTrust, &trustResult);
    NSAssert(status == errSecSuccess, @"信任评估失败");

    // 提取私钥
    status = SecIdentityCopyPrivateKey(myIdentity, &_privateKeyRef);
    NSAssert(status == errSecSuccess, @"私钥创建失败");
    
    if (_identitys) {
        
        CFRelease(_identitys);
    }
    _identitys = items;
}

-(NSData *)RSAEncryptData:(NSData *)data
{
//    NSString* keyName = @"MeetingPublicKey";
    OSStatus sanityCheck = noErr;
    SecKeyRef publicKeyRef = _publicKeyRef;
    NSMutableData* cipherData = [NSMutableData data];
    
    if (NULL == publicKeyRef)
    {
        return nil;
    }
    
    size_t cipherLen = SecKeyGetBlockSize(publicKeyRef);
    void *blockBuf = malloc(sizeof(uint8_t) * MAX_BLOCK_SIZE);
    void *cipherTextBuf = malloc(sizeof(uint8_t) * cipherLen);
    NSInteger plainTextLen = [data length];
    
    for (int i = 0 ; i < plainTextLen; i += MAX_BLOCK_SIZE) {
        long blockSize = MIN(MAX_BLOCK_SIZE, plainTextLen - i);
        memset(blockBuf, 0, MAX_BLOCK_SIZE);
        memset(cipherTextBuf, 0, cipherLen);
        [data getBytes:blockBuf range:NSMakeRange(i, blockSize)];
        sanityCheck = SecKeyEncrypt(publicKeyRef,
                                    kSecPaddingPKCS1,//修改了加密类型的值以后可正常加密
                                    blockBuf,
                                    blockSize,
                                    cipherTextBuf,
                                    &cipherLen);
        
        if(sanityCheck == noErr) {
            [cipherData appendBytes:cipherTextBuf length:cipherLen];
        } else {
            cipherData = nil;
            break;
        }
    }
    
    free(blockBuf);
    free(cipherTextBuf);
    
    return cipherData;


}

-(NSData *)RSADecryptData:(NSData *)data
{
    OSStatus sanityCheck = noErr;
    size_t cipherBufferSize = 0;
    size_t keyBufferSize = 0;
    
    NSData *key = nil;
    uint8_t *keyBuffer = NULL;
    
    SecKeyRef privateKey = _privateKeyRef;
    NSAssert(privateKey != NULL, @"私钥不存在");
    
    // 计算缓冲区大小
    cipherBufferSize = SecKeyGetBlockSize(privateKey);
    keyBufferSize = data.length;
    
    NSAssert(keyBufferSize <= cipherBufferSize, @"解密内容太大");
    
    // 分配缓冲区
    keyBuffer = malloc(keyBufferSize * sizeof(uint8_t));
    memset((void *)keyBuffer, 0x0, keyBufferSize);
    
    // 使用私钥解密
    sanityCheck = SecKeyDecrypt(privateKey,
                                kTypeOfWrapPadding,
                                (const uint8_t *)data.bytes,
                                cipherBufferSize,
                                keyBuffer,
                                &keyBufferSize
                                );
    
    NSAssert1(sanityCheck == noErr, @"解密错误，OSStatus == %d", sanityCheck);
    
    // 生成明文数据
    key = [NSData dataWithBytes:(const void *)keyBuffer length:(NSUInteger)keyBufferSize];
    
    if (keyBuffer) free(keyBuffer);
    
    return key;

}
- (void)removePublicKey:(NSString *)keyName
{
    OSStatus sanityCheck = noErr;
    
    NSAssert( keyName != nil, @"Peer name parameter is nil." );
    
    NSData * peerTag = [[NSData alloc] initWithBytes:(const void *)[keyName UTF8String] length:[keyName length]];
    NSMutableDictionary * peerPublicKeyAttr = [[NSMutableDictionary alloc] init];
    
    [peerPublicKeyAttr setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [peerPublicKeyAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [peerPublicKeyAttr setObject:peerTag forKey:(__bridge id)kSecAttrApplicationTag];
    
    sanityCheck = SecItemDelete((__bridge CFDictionaryRef) peerPublicKeyAttr);
    
    //    LOGGING_FACILITY1( sanityCheck == noErr || sanityCheck == errSecItemNotFound, @"Problem deleting the peer public key to the keychain, OSStatus == %ld.", sanityCheck );
    
}

@end
