//
//  HeaderMeView.m
//  XianJinBao
//
//  Created by 廉英雷 on 16/3/3.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "HeaderMeView.h"
#import "Tools.h"

#import "UIView+XLExtension.h"

@interface HeaderMeView ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *jobNumerLab;

@end
@implementation HeaderMeView

- (instancetype)initWithFrame:(CGRect)frame{
      
     self = [super initWithFrame:frame];
      if (self) {
            
            [self creatView];
      }

      return self;
}

- (void)setImgStr:(NSString *)imgStr{
      _imgStr = imgStr;

      self.imgView.image = [UIImage imageNamed:imgStr];
      
      //保存照片到沙盒
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
      path = [path stringByAppendingPathComponent:@"headImage.png"];
      NSLog(@"照片的路径-----%@",path);
      NSData *data = UIImagePNGRepresentation(self.imgView.image);
      [data writeToFile:path atomically:YES];


     
}

- (void)setNameStr:(NSString *)nameStr{

      _nameStr = nameStr;
      
      self.nameLab.text = self.nameStr;
      
      
}

- (void)setJobNumber:(NSString *)jobNumber{

      _jobNumber = jobNumber;
      
      self.jobNumerLab.text = [@"手机号:" stringByAppendingString:self.jobNumber];
}

- (void)creatView{
      UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.width, self.height - 10)];
      [self addSubview:backImageView];
      backImageView.userInteractionEnabled = YES;
      backImageView.image = [UIImage imageNamed:@"wode_bg.png"];
      
      UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
      [self addSubview:imgView];
      imgView.image = [UIImage imageNamed:@"tu06.png"];
      self.imgView = imgView;
      //imgView.image = [[Tools shareTools] headerImage];
//      imgView.layer.cornerRadius = 45;
//      imgView.layer.masksToBounds = YES;
      imgView.contentMode = UIViewContentModeScaleAspectFit;
      imgView.backgroundColor = [UIColor whiteColor];
      
      UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+15,imgView.y+15, 200, 30)];
      self.nameLab = lab;
      lab.textAlignment = NSTextAlignmentLeft;
      lab.textColor = [UIColor whiteColor];
      lab.font = [UIFont systemFontOfSize:18];
      lab.text = @"";
     // lab.text = self.nameStr;
//      lab.font = [UIFont boldSystemFontOfSize:20];
//      lab.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(36.0)];
      //[lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
     // [lab sizeToFit];
      [self addSubview:lab];
      UIImageView *imgVip = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame), lab.y, 15, 15)];
      [self addSubview:imgVip];
      imgVip.image = [UIImage imageNamed:@"vip.png"];
      imgVip.contentMode = UIViewContentModeScaleAspectFill;
      // lab.textAlignment =  NSTextAlignmentCenter;
      lab.font = [UIFont systemFontOfSize:15];
      
      UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+15, CGRectGetMaxY(lab.frame), 200, 30)];
      
      self.jobNumerLab = labName;
      labName.textAlignment = NSTextAlignmentLeft;
      labName.text = @"工号:";
   
      labName.font = [UIFont systemFontOfSize:15];
      labName.textColor = [UIColor whiteColor];
      
      [self addSubview:labName];
      
      UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(_width-30, imgView.centerY -11, 14, 25)];
      [backImageView addSubview:leftBtn];
      [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
      [leftBtn addTarget:self action:@selector(leftBtnClcik) forControlEvents:UIControlEventTouchUpInside];
}

- (void)leftBtnClcik{


}


//- (UIImage *)headerImage{
//      
//      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)lastObject];
//      path = [path stringByAppendingPathComponent:@"headImage.png"];
//      NSData *imgDate = [NSData dataWithContentsOfFile:path];
//      UIImage *img = [UIImage imageWithData:imgDate];
//      return img;
//}
@end
