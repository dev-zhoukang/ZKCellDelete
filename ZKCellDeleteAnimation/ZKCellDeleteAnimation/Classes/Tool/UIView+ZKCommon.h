//
//  UIView+ZKCommon.h
//  HTWallet
//
//  Created by ZK on 16/10/17.
//  Copyright © 2016年 MaRuJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZKCommon)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

/**
 Set the anchorPoint of view without changing is perceived position.
 
 @param anchorPoint new anchorPoint of the view in unit coords (e.g., {0.5,1.0})
 @param xConstraint an NSLayoutConstraint whose constant property adjust's view x.center
 @param yConstraint an NSLayoutConstraint whose constant property adjust's view y.center
 
 As multiple constraints can contribute to determining a view's center, the user of this
 function must specify which constraint they want modified in order to compensate for the
 modification in anchorPoint
 */
- (void)setAnchorPointMotionlessly:(CGPoint)anchorPoint xConstraint:(NSLayoutConstraint *)xConstraint yConstraint:(NSLayoutConstraint *)yConstraint;

@end
