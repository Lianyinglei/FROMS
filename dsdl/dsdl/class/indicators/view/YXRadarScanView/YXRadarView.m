//
//  YXRadarView.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "YXRadarView.h"
#import "YXRadarIndictorView.h"
#import "UIView+XLExtension.h"

#define RADAR_DEFAULT_SECTIONS_NUM 3
#define RADAR_DEFAULT_RADIUS 100.f
#define RADAR_ROTATE_SPEED 60.f
#define INDICATOR_START_COLOR [UIColor colorWithRed:255.0/192.0 green:203.0/255.0 blue: 46.0/255.0 alpha:1]
#define INDICATOR_END_COLOR [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue: 250.0/255.0 alpha:0]
#define INDICATOR_ANGLE 90.f
#define INDICATOR_CLOCKWISE YES
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

@implementation YXRadarView

static NSString * const rotationAnimationKey = @"rotationAnimation";

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if (!self.indicatorView) {
        YXRadarIndictorView *indicatorView = [[YXRadarIndictorView alloc] initWithFrame:self.bounds];
        [self addSubview:indicatorView];
        self.indicatorView = indicatorView;
    }
    
    if (!self.textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y + self.radius, self.bounds.size.width, 30)];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    
    if(!self.pointsView) {
        UIView *pointsView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:pointsView];
        self.pointsView = pointsView;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 画布
    CGContextRef context =  UIGraphicsGetCurrentContext();
    // 背景图片
    if (self.backgroundImage) {
        UIImage *image = self.backgroundImage;
        [image drawInRect:self.bounds]; // 画出图片
    }
    
    NSInteger sectionsNum = RADAR_DEFAULT_SECTIONS_NUM;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInRadarView:)]) {
        sectionsNum = [self.dataSource numberOfSectionsInRadarView:self];
    }
    
    CGFloat radius = RADAR_DEFAULT_RADIUS;
    if (self.radius) {
        radius = self.radius;
    }
    
    CGFloat indicatorAngle = INDICATOR_ANGLE;
    if (self.indicatorAngle) {
        indicatorAngle = self.indicatorAngle;
    }
    
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    if (self.indicatorClockwise) {
        indicatorClockwise = self.indicatorClockwise;
    }
    
    UIColor *indicatorStartColor = INDICATOR_START_COLOR;
      
    if (self.indicatorStartColor) {
        indicatorStartColor = self.indicatorStartColor;
    }
    
    UIColor *indicatorEndColor = INDICATOR_END_COLOR;
    if (self.indicatorEndColor) {
        indicatorEndColor = self.indicatorEndColor;
    }
#pragma mark----画坐标轴-----------
    
    // 画图坐标轴
    CGFloat r = self.bounds.size.width *0.5;
    CGContextMoveToPoint(context, r, 0);
      
    //  [UIColor colorWithRed:59.0/192.0 green:135.0/255.0 blue: 112.0/255.0 alpha:1]
    CGContextSetRGBStrokeColor(context, 222.0/255, 242.0/255, 253.0/255, 1); //
    CGContextSetLineWidth(context, 2.0);    // 线宽
    CGContextAddLineToPoint(context, self.bounds.size.width *0.5, self.bounds.size.height);
      
    CGContextMoveToPoint(context,(1-sqrt(3)*0.5)*r, r*0.5);
    CGContextAddLineToPoint(context, (1+sqrt(3)*0.5)*r, self.bounds.size.height*0.75);
      
      CGContextMoveToPoint(context, r*(1+sqrt(3)*0.5) , self.bounds.size.width *0.25);
      CGContextAddLineToPoint(context, (1-sqrt(3)*0.5)*r, self.bounds.size.height *0.75);
      
     
      
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);

    CGFloat sectionRadius = radius / sectionsNum;
    for (int i = 0; i < sectionsNum; i++) {
        
        // 画圈
        CGContextSetLineWidth(context, 2.0);    // 线宽
        CGContextAddArc(context, self.center.x, self.center.y, sectionRadius - 5 * (sectionsNum - i - 1), 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);
        sectionRadius += radius / sectionsNum;
          
    }
    
    if (self.indicatorView) {
        self.indicatorView.frame = self.bounds;
        self.indicatorView.backgroundColor = [UIColor clearColor];
        self.indicatorView.radius = self.radius;
        self.indicatorView.angle = indicatorAngle;
        self.indicatorView.clockwise = indicatorClockwise;
        self.indicatorView.startColor = indicatorStartColor;
        self.indicatorView.endColor = indicatorEndColor;
    }
    
    if (self.textLabel) {
        self.textLabel.frame = CGRectMake(0, self.center.y + ([UIScreen mainScreen].bounds.size.height)/3.3, rect.size.width, 30);
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:13.f];
        if (self.labelText) {
            self.textLabel.text = self.labelText;
        }
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self bringSubviewToFront:self.textLabel];
    }
}

- (void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    if (self.textLabel) {
        self.textLabel.text = labelText;
    }
}

#pragma mark - Actions
- (void)scan
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    if (self.indicatorClockwise) {
        indicatorClockwise = self.indicatorClockwise;
    }
    rotationAnimation.toValue = [NSNumber numberWithFloat:(indicatorClockwise?1:-1) * M_PI * 2.0];
    rotationAnimation.duration = 360.f / RADAR_ROTATE_SPEED;
    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = INT_MAX;
      rotationAnimation.repeatCount = HUGE_VALF;
    [self.indicatorView.layer addAnimation:rotationAnimation forKey:rotationAnimationKey];
}


- (void)stop
{
    [self.indicatorView.layer removeAnimationForKey:rotationAnimationKey];
}

- (void)show
{
    for (UIView *subView in self.pointsView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfPointsInRadarView:)]) {
        NSUInteger pointsNum = [self.dataSource numberOfPointsInRadarView:self];
        for (int index = 0; index < pointsNum; index++) {
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(radarView:viewForIndex:)]) {
                if(self.dataSource && [self.dataSource respondsToSelector:@selector(radarView:positionForIndex:)]){
                    
                    CGPoint point = [self.dataSource radarView:self positionForIndex:index];
//                    CGFloat posDirection = point.x;     // 方向（角度）
//                    CGFloat posDistance = point.y;      // 距离(半径)
                    
                      
                    YXRadarPointView *pointView = [[YXRadarPointView alloc] initWithFrame:CGRectZero];
                    UIView *customView = [self.dataSource radarView:self viewForIndex:index];

                    [pointView addSubview:customView];
                    pointView.tag = index;
                    pointView.frame = customView.frame;
                      pointView.center = point;
                    //  pointView.size = CGSizeMake(15, 15);
                  
//                      pointView.x = point.x -customView.height *0.5;
//                      point.y = point.y- customView.height *0.5;
//                    pointView.center = CGPointMake(self.center.x + posDistance*sin(DEGREES_TO_RADIANS(posDirection)), self.center.y + posDistance * cos(DEGREES_TO_RADIANS(posDirection)));
                    //  pointView.backgroundColor = [UIColor blueColor];
                    pointView.delegate = self;
                    
                    // 动画
                    pointView.alpha = 0.0;
                    CGAffineTransform fromTransform = CGAffineTransformScale(pointView.transform, 0.1, 0.1);
                    [pointView setTransform:fromTransform];
                    
                    CGAffineTransform toTransform = CGAffineTransformConcat(pointView.transform, CGAffineTransformInvert(pointView.transform));
                    
                    double delayInSeconds = 0.1 * index;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                        [UIView beginAnimations:nil context:NULL];
                        [UIView setAnimationDuration:0.5];
                        pointView.alpha = 1.0;
                        [pointView setTransform:toTransform];
                        [UIView commitAnimations];
                    });
                    
                    [self.pointsView addSubview:pointView];
                }
            }
        }
    }
}

- (void)hide
{
    
}

#pragma mark - YXRadarPointViewDelegate

- (void)didSelectItemRadarPointView:(YXRadarPointView *)radarPointView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(radarView:didSelectItemAtIndex:)]) {
        [self.delegate radarView:self didSelectItemAtIndex:radarPointView.tag];
    }
}


@end
