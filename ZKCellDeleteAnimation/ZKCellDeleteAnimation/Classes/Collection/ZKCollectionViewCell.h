//
//  ZKCollectionViewCell.h
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKCollectionViewController;

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface ZKCollectionViewCell : UICollectionViewCell

- (void)updateCelWithTitle:(NSString *)title baseVC:(ZKCollectionViewController *)baseVC;

@end
