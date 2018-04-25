//
//  UIImageView+Category.m
//  framework
//
//  Created by yoxnet on 16/4/7.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import "UIImageView+Category.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView(AsynRemote)

- (void)yox_setImageWithURLString:(NSString *)urlString
                 placeholderImage:(id)placeholderImagePath
                         progress: (void(^)(NSInteger receivedSize, NSInteger expectedSize))ImageDownloaderProgressBlock
                        completed:(void(^)(UIImage *image, NSURL *imageURL))completedBlock;
{
    [self yox_setImageWithURLString:urlString
                   placeholderImage:placeholderImagePath
                            options:0
                           progress:ImageDownloaderProgressBlock
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                             
                              completedBlock(image,imageURL);
                              
                          }];
}


-(void)yox_setImageWithURLString:(NSString *)urlString
                placeholderImage:(id)placeholderImagePath
                        clipSize:(CGSize)size;
{
    NSRange rang = [urlString rangeOfString:@"." options:NSBackwardsSearch];
    NSString * suffix ;
    
    if (rang.location == NSNotFound) {
        suffix = @"";
    }else{
    
        NSString * fileType = [urlString substringFromIndex:rang.location];
        
        suffix = [NSString stringWithFormat:@"_%ldx%ld%@",(NSInteger)size.width,(NSInteger)size.height,fileType];
        
    }
    NSLog(@"%@",[urlString stringByAppendingString:suffix]);
    
    [self yox_setImageWithURLString:[urlString stringByAppendingString:suffix] placeholderImage:placeholderImagePath options:0 progress:nil completed:nil];
    
}

-(void)yox_setImageWithURLString:(NSString *)urlString placeholderImage:(id)placeholderImagePath;
{
    
    [self yox_setImageWithURLString:urlString placeholderImage:placeholderImagePath options:0 progress:nil completed:nil];
    
}
- (void)yox_setImageWithURLString:(NSString *)urlString placeholderImage:(id)placeholderImagePath options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    NSURL * url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    UIImage * placeholder;
    
    if ([placeholderImagePath isKindOfClass:[UIImage class]]) {
        
        placeholder = placeholderImagePath;
        
    }else if ([placeholderImagePath isKindOfClass:[NSString class]]&&[placeholderImagePath valueForKey:@"length"]) {
        
        placeholder = [UIImage imageNamed:placeholderImagePath];
        
    } else {
        
        placeholder = nil;
        
    }
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];

}





@end
