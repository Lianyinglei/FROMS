//
//  loadView.h
//  ehking-pos-ios
//
//  Created by 廉英雷 on 15/9/30.
//  Copyright © 2015年 ehking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadView : UIView

@property(nonatomic,strong)UIView * mainView;//主界面

@property(nonatomic,strong)UIActivityIndicatorView * activtyView;

@property(nonatomic,strong)UILabel * textLabel;

@property(nonatomic,strong)UIImageView * loadImageView;

@property(nonatomic,strong)UIImageView * progressImageView;


-(void)startLoadWithTitle:(NSString *)title;

-(void)stopLoading;


@end
