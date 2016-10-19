//
//  ZKTopIndicator.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKTopIndicator.h"

UIWindow *window_;
NSTimer *timer_;

@implementation ZKTopIndicator

+ (void)showWithTitle:(NSString *)title dismissTime:(NSTimeInterval)time
{
    [self setupUIWithTitle:title];
    
    [self showIndicatorWithBlock:^(){
        timer_ = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideIndicator) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
    }];
}

+ (void)hideIndicator
{
    [UIView animateWithDuration:0.35 animations:^{
        window_.bottom = 0;
    }];
}

+ (void)showIndicatorWithBlock:(void(^)())block
{
    window_.bottom = 0;
    window_.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        window_.bottom = 100.f;
    } completion:^(BOOL finished) {
        !block?:block();
    }];
}

+ (void)setupUIWithTitle:(NSString *)title
{
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor orangeColor];
    [window_ setWindowLevel:UIWindowLevelStatusBar];
    window_.size = (CGSize){SCREEN_WIDTH, SCREEN_HEIGHT};
    window_.top = 0;
    
    UILabel *label = [[UILabel alloc] init];
    [window_ addSubview:label];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.size = (CGSize){window_.width, 100.f};
    label.bottom = window_.height;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineSpacing = 4.f;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:16.f],
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:style,
                                  };
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    
    label.attributedText = attributedString;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [window_ addGestureRecognizer:panGesture];
}

+ (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        [timer_ invalidate];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded||panGesture.state == UIGestureRecognizerStateCancelled) {
        [self hideIndicator];
    }
    
    CGPoint translation = [panGesture translationInView:panGesture.view];
    
    CGRect frame = panGesture.view.frame;
    frame.origin.y += translation.y;
    panGesture.view.frame = frame;
    
    // 别忘复位, 很关键
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

@end
