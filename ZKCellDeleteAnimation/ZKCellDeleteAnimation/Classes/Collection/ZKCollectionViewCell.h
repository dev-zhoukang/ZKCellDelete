//
//  ZKCollectionViewCell.h
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZKCollectionViewController;

@interface ZKCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *borderView;

- (void)updateCelWithTitle:(NSString *)title baseVC:(ZKCollectionViewController *)baseVC;

@end
