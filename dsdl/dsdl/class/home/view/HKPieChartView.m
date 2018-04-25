//
//  HKPieChartView.m
//  PieChart
//
//  Created by hukaiyin on 16/6/20.
//  Copyright © 2016年 HKY. All rights reserved.
//


#import "HKPieChartView.h"

@interface HKPieChartView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, assign) UIColor *trackColor;
@property (nonatomic, weak) UIColor *progressColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) CGFloat percent; //饼状图显示的百分比，最大为100
@property (nonatomic, assign) CGFloat animationDuration;//动画持续时长
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, assign) CGFloat pathWidth;
@property (nonatomic, assign) CGFloat sumSteps;
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, assign) BOOL panAnimationing;

@end

@implementation HKPieChartView

#pragma mark - Life Cycle

- (void)setRoundStr:(NSString *)roundStr{

      _roundStr = roundStr;
      self.progressLabel.text = roundStr;

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self updateUI];
         // self.backgroundColor = kUIColorFromRGB(0x4ac6ff);
          
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
}

- (void)updateUI {
      
   // self.trackColor = [UIColor blackColor];
      //self.trackColor = kUIColorFromRGB(0x6bcffd);
      self.trackColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1.0];
     // self.trackColor = [UIColor blueColor];
      self.progressColor = [UIColor whiteColor];
    self.animationDuration = 3.0;
    self.pathWidth = self.bounds.size.width / 1.15;
      
    
    [self shadowImageView];
//    [self trackLayer];
      _trackLayer = [CAShapeLayer layer];
//      [self loadLayer:_trackLayer WithColor:self.trackColor];
      CGFloat layerWidth = self.pathWidth;
      CGFloat layerX = (self.bounds.size.width - layerWidth)/2;
      _trackLayer.frame = CGRectMake(layerX, layerX, layerWidth, layerWidth);
     _trackLayer.fillColor = [UIColor clearColor].CGColor;
      
      _trackLayer.strokeColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1.0].CGColor;
      
      _trackLayer.lineCap = kCALineCapButt;
     _trackLayer.lineWidth = self.lineWidth;
      _trackLayer.path = self.path.CGPath;
      [self.layer addSublayer:_trackLayer];
    [self gradientLayer];
    [self loadGesture];
}

#pragma mark - Load

- (void)loadLayer:(CAShapeLayer *)layer WithColor:(UIColor *)color {
    
    CGFloat layerWidth = self.pathWidth;
    CGFloat layerX = (self.bounds.size.width - layerWidth)/2;
    layer.frame = CGRectMake(layerX, layerX, layerWidth, layerWidth);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineCap = kCALineCapButt;
    layer.lineWidth = self.lineWidth;
    layer.path = self.path.CGPath;
}

- (void)loadGesture {
      
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - Gesture Action

- (void)didPan:(UIPanGestureRecognizer *)pan {
    if (!self.panAnimationing) {
        
    }
}

#pragma mark - Animation

- (void)updatePercent:(CGFloat)percent animation:(BOOL)animationed {
    self.percent = percent;
    [self.progressLayer removeAllAnimations];
    
    if (!animationed) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:1];
        
        self.progressLayer.strokeEnd = self.percent / 100.0;
        
        [CATransaction commit];
    } else {
        CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0.0);
        animation.toValue = @(self.percent / 100.0);
        animation.duration = self.animationDuration * self.percent / 100.0;
        animation.removedOnCompletion = YES;
        animation.delegate = self;
        animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

        self.progressLayer.strokeEnd = self.percent / 100.0;
        [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    self.timer = [NSTimer timerWithTimeInterval:1/60.f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self invalidateTimer];
        self.progressLabel.text = [NSString stringWithFormat:@"%0.2f", self.percent];
          self.progressLabel.text = self.roundStr;
    }
}

- (void)timerAction {
      
      
    id strokeEnd = [[_progressLayer presentationLayer] valueForKey:@"strokeEnd"];
    if (![strokeEnd isKindOfClass:[NSNumber class]]) {
        return;
    }
      
    CGFloat progress = [strokeEnd floatValue];
    self.progressLabel.text = [NSString stringWithFormat:@"%0.2f",(progress * 100)];
      self.progressLabel.text = self.roundStr;
      
}

- (void)invalidateTimer {
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Getters & Setters

- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        [self loadLayer:_trackLayer WithColor:self.trackColor];
        [self.layer addSublayer:_trackLayer];
    }
    return _trackLayer;
}

- (UIImageView *)shadowImageView {
    if (!_shadowImageView) {
        _shadowImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _shadowImageView.image = [UIImage imageNamed:@"shadow"];
        [self addSubview:_shadowImageView];
    }
    return _shadowImageView;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        [self loadLayer:_progressLayer WithColor:self.progressColor];
        _progressLayer.strokeEnd = 0;
    }
    return _progressLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)kUIColorFromRGB(0x0088fc).CGColor,
                                 (id)kUIColorFromRGB(0x00fcff).CGColor,(id)kUIColorFromRGB(0xe8f0f3).CGColor,(id)kUIColorFromRGB(0x71ff6a).CGColor,(id)kUIColorFromRGB(0xe8f0f3).CGColor];
        [_gradientLayer setStartPoint:CGPointMake(0.5, 0.1)];
        [_gradientLayer setEndPoint:CGPointMake(0.3, 0.9)];
        
        [_gradientLayer setMask:self.progressLayer];
        [self.layer addSublayer:_gradientLayer];
        
    }
    return _gradientLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]initWithFrame:self.bounds];
          _progressLabel.textColor = kUIColorFromRGB(0x23b89c);
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:26];

        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    _percent = _percent > 100 ? 100 : _percent;
    _percent = _percent < 0 ? 0 : _percent;
}

- (UIBezierPath *)path {
    if (!_path) {
          
        
        CGFloat halfWidth = self.pathWidth / 2;
        _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfWidth, halfWidth)
                                               radius:(self.pathWidth - self.lineWidth)/2
                                           startAngle:-M_PI/2
                                             endAngle:M_PI/2*3
                                            clockwise:YES];
    }
    return _path;
}

- (CGFloat)lineWidth {
    if (_lineWidth == 0) {
        _lineWidth = 6.0;
    }
    return _lineWidth;
}

@end