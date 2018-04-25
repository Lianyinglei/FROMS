//
//  UIImageView+Category.h
//  framework
//
//  Created by yoxnet on 16/4/7.
//  Copyright © 2016年 yoxnet. All rights reserved.
//

#import <UIKit/UIKit.h>

/*************************
 *
 *
 *   远程异步加载图片 方便后期管理，不直接使用第三方库
 *   依赖/libs/SDWebImage
 *
 *
 **************************/

@interface UIImageView (AsynRemote)


-(void)yox_setImageWithURLString:(NSString *)urlString placeholderImage:(id)placeholderImagePath;

/*********************
 *
 *  placeholderImagePath 本地图片 为NSString(本地图片名)或者UIImage
 *
 *  size 需要裁剪到的尺寸 如果服务器支持，会在urlString后边拼接size的 widthxheight.xxx 参数
 *
 *
 *  注意：该方法urlString必须有文件后缀名
 *
 *********************/

-(void)yox_setImageWithURLString:(NSString *)urlString
                placeholderImage:(id)placeholderImagePath
                        clipSize:(CGSize)size;





- (void)yox_setImageWithURLString:(NSString *)urlString
                 placeholderImage:(id)placeholderImagePath
                         progress: (void(^)(NSInteger receivedSize, NSInteger expectedSize))ImageDownloaderProgressBlock
                        completed:(void(^)(UIImage *image, NSURL *imageURL))completedBlock;









@end
