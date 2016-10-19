//
//  ZKTopHintView.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKTopHintView.h"

@interface ZKTopHintView ()

@property (nonatomic, copy) NSString *hintStr;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation ZKTopHintView

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
//    self.backgroundColor = [UIColor orangeColor];
//    [self setWindowLevel:UIWindowLevelStatusBar];
//    self.frame = (CGRect){CGPointZero, SCREEN_WIDTH, 100.f};
//    self.hidden = NO;
    
//    _hintLabel = [[UILabel alloc] init];
//    [self addSubview:_hintLabel];
//    _hintLabel.numberOfLines = 0;
//    _hintLabel.textAlignment = NSTextAlignmentCenter;
//    _hintLabel.size = (CGSize){self.width, self.height};
//    _hintLabel.centerY = self.centerY;
}

#pragma mark - Pub

+ (void)showWithTitle:(NSString *)title dismissTime:(NSTimeInterval)time
{
    ZKTopHintView *hintView = [[ZKTopHintView alloc] init];
    
    hintView.backgroundColor = [UIColor orangeColor];
    [hintView setWindowLevel:UIWindowLevelStatusBar];
    hintView.frame = (CGRect){CGPointZero, SCREEN_WIDTH, 100.f};
    hintView.hidden = NO;
    
    hintView.hintStr = [title copy];
    [hintView makeKeyAndVisible];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)setHintStr:(NSString *)hintStr
{
    _hintStr = [hintStr copy];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineSpacing = 4.f;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:16.f],
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:style,
                                  };
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithString:@"长按显示删除按钮\n单击两次交换两者位置" attributes:attributes];
    
    _hintLabel.attributedText = attributedString;
}

@end
