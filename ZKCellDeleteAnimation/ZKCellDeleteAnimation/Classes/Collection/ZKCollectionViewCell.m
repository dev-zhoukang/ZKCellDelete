//
//  ZKCollectionViewCell.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKCollectionViewCell.h"
#import "UIView+AutoLayout.h"
#import "UIView+ZKCommon.h"
#import "MacroToolHeader.h"
#import "ZKCollectionViewController.h"

@interface ZKCollectionViewCell () {
    NSLayoutConstraint *_topConstraint;
    NSLayoutConstraint *_bottomConstraint;
    NSLayoutConstraint *_leftConstraint;
    NSLayoutConstraint *_rightConstraint;
}

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) ZKCollectionViewController *baseViewController;

@end

@implementation ZKCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _topConstraint = [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    _bottomConstraint = [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10*WindowZoomScale];
    _leftConstraint = [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    _rightConstraint = [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10*WindowZoomScale];
    
    NSLayoutConstraint *leftConstraint = [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    NSLayoutConstraint *topConstraint = [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    
    CGFloat insetValue = 10;
    _deleteBtn.contentEdgeInsets = UIEdgeInsetsMake(10*WindowZoomScale-19/2.0, 0, 0, 15*WindowZoomScale-19/2.0);
    CGPoint anchorPoint = CGPointMake((_deleteBtn.width-insetValue)/_deleteBtn.width,0);
    [_deleteBtn setAnchorPointMotionlessly:anchorPoint xConstraint:leftConstraint yConstraint:topConstraint];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [_imageView addGestureRecognizer:longPress];
}

#pragma mark - Actions

- (void)handleLongPress:(UILongPressGestureRecognizer *)longGesture
{
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按");
        ZKPerformSelectorLeakWarning(
            [_baseViewController performSelector:NSSelectorFromString(@"beginEdit")];
        );
    }
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    _titleLabel.text = title;
    [self updateViewsLayout];
}

- (void)startEditSwitchAnimation
{
    [self updateViewsLayout];
    
    CGAffineTransform lastTransform = CGAffineTransformIdentity;
    if ([_baseViewController isEditing]) {
        _deleteBtn.transform = CGAffineTransformMakeScale(0.001, 0.001);
    }
    else {
        lastTransform = CGAffineTransformMakeScale(0.001, 0.001);
        _deleteBtn.hidden = YES;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _deleteBtn.transform = lastTransform;
        [self layoutIfNeeded];
    }];
}

- (void)updateViewsLayout
{
    NSLog(@" === %zd == %@", [_baseViewController isEditing], _baseViewController);
    
    if ([_baseViewController isEditing]) {
        
        _deleteBtn.hidden = NO;
        
        _topConstraint.constant = 10*WindowZoomScale;
        _bottomConstraint.constant = 10*WindowZoomScale;
        _leftConstraint.constant = 5*WindowZoomScale;
        _rightConstraint.constant = 15*WindowZoomScale;
    }
    else {
        _deleteBtn.hidden = YES;
        
        _topConstraint.constant = 0;
        _bottomConstraint.constant = 10*WindowZoomScale;
        _leftConstraint.constant = 0;
        _rightConstraint.constant = 10*WindowZoomScale;
    }
}

#pragma mark - Pub

- (void)updateCelWithTitle:(NSString *)title baseVC:(ZKCollectionViewController *)baseVC
{
    _title = [title copy];
    _baseViewController = baseVC;
    
    _titleLabel.text = title;
    
    [self updateViewsLayout];
}

@end
