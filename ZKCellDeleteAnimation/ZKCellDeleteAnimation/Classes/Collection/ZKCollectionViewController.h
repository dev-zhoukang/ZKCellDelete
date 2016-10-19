//
//  ZKCollectionViewController.h
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKCollectionViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL isEditing;

- (void)beginEdit;
- (void)finishEdit;

@end
