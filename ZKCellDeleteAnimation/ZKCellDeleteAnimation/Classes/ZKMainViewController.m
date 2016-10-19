//
//  ZKMainViewController.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKMainViewController.h"
#import "ZKCollectionViewController.h"

@interface ZKMainViewController ()

@end

@implementation ZKMainViewController

#pragma mark - Actions

- (IBAction)collectionBtnClick
{
    ZKCollectionViewController *collectionVC = [[ZKCollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
}

- (IBAction)tableBtnClick
{
    
}

@end
