//
//  NSString+Category.m
//  framework
//
//  Created by yoxnet on 16/3/31.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Security)


-(NSString *)to16MD5String;
{
    
    return [self toMD5StringWithLength:16];
    
}

-(NSString *)to32MD5String;
{
    return [self toMD5StringWithLength:32];
}

-(NSString *)toMD5StringWithLength:(NSInteger)len
{
    const char *cStr = [self UTF8String];
    
    unsigned char result[len];
    
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    NSMutableString * mutable = [[NSMutableString alloc] initWithCapacity:len*2];
    
    for (int i = 0; i < len; i++) {
        [mutable appendFormat:@"%02X",result[i]];
    }
    return [mutable copy];
}
- (NSString *)RSAEncryptStringWithSecretTool:(SecretTool *)tool;
{
    
    NSData * data = [tool RSAEncryptData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString * str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return str;
}



- (NSString *)RSADecryptStringWithSecretTool:(SecretTool *)tool;
{
    NSData * data = [tool RSADecryptData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
@end


@implementation NSString (Regular)


-(BOOL)isNumber;
{
    NSString* regex = @"^\\d{1,}$";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  
    return [pred evaluateWithObject:self];

}

-(BOOL)isMobileNumber;
{
    //手机号以1 十个 \d 数字字符
    NSString *phoneRegex = @"^(1）\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}


-(BOOL)isPassword;
{
    NSString* regex = @"^[[0-9]|[a-z,A-Z]]{6,16}$";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([pred evaluateWithObject:self])
    {
        if ([self isNumber]) {
            
            return NO;
        }
        if ([self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location==NSNotFound) {
            return NO;
        }
        return YES;
        
    }
    return NO;
}
@end


@implementation NSString(AutoSize)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
      NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
      attrs[NSFontAttributeName] = font;
      CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
      
      // 获得系统版本
      
      return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
      return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
