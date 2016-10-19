//
//  UIView+ZKCommon.m
//  HTWallet
//
//  Created by ZK on 16/10/17.
//  Copyright © 2016年 MaRuJun. All rights reserved.
//

#import "UIView+ZKCommon.h"

@implementation UIView (ZKCommon)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/**
 Set the anchorPoint of view without changing is perceived position.
 
 @param view view whose anchorPoint we will mutate
 @param anchorPoint new anchorPoint of the view in unit coords (e.g., {0.5,1.0})
 @param xConstraint an NSLayoutConstraint whose constant property adjust's view x.center
 @param yConstraint an NSLayoutConstraint whose constant property adjust's view y.center
 
 As multiple constraints can contribute to determining a view's center, the user of this
 function must specify which constraint they want modified in order to compensate for the
 modification in anchorPoint
 */
- (void)setAnchorPointMotionlessly:(CGPoint)anchorPoint xConstraint:(NSLayoutConstraint *)xConstraint yConstraint:(NSLayoutConstraint *)yConstraint
{
    // assert: old and new anchorPoint are in view's unit coords
    CGPoint const oldAnchorPoint = self.layer.anchorPoint;
    CGPoint const newAnchorPoint = anchorPoint;
    
    // Calculate anchorPoints in view's absolute coords
    CGPoint const oldPoint = CGPointMake(self.bounds.size.width * oldAnchorPoint.x,
                                         self.bounds.size.height * oldAnchorPoint.y);
    CGPoint const newPoint = CGPointMake(self.bounds.size.width * newAnchorPoint.x,
                                         self.bounds.size.height * newAnchorPoint.y);
    
    // Calculate the delta between the anchorPoints
    CGPoint const delta = CGPointMake(newPoint.x-oldPoint.x, newPoint.y-oldPoint.y);
    
    // get the x & y constraints constants which were contributing to the current
    // view's position, and whose constant properties we will tweak to adjust its position
    CGFloat const oldXConstraintConstant = xConstraint.constant;
    CGFloat const oldYConstraintConstant = yConstraint.constant;
    
    // calculate new values for the x & y constraints, from the delta in anchorPoint
    // when autolayout recalculates the layout from the modified constraints,
    // it will set a new view.center that compensates for the affect of the anchorPoint
    CGFloat const newXConstraintConstant = oldXConstraintConstant + delta.x;
    CGFloat const newYConstraintConstant = oldYConstraintConstant + delta.y;
    
    self.layer.anchorPoint = newAnchorPoint;
    xConstraint.constant = newXConstraintConstant;
    yConstraint.constant = newYConstraintConstant;
    [self setNeedsLayout];
}


@end
