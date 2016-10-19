

//
//  ZKCollectionViewController.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKCollectionViewController.h"
#import "ZKCollectionViewCell.h"
#import "ZKTopHintView.h"

@interface ZKCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *bottomView;

// 新功能

@property (nonatomic, strong) NSIndexPath *seletedIndexPath;

@end

static NSString *const kCellIdentify = @"ZKCollectionViewCell";

@implementation ZKCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self setupUI];
}

- (void)initData
{
    _dataSource = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 30; i ++) {
        [_dataSource addObject:[NSString stringWithFormat:@"第%zd个", i]];
    }
    [_collectionView reloadData];
}

- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 2;
    
    _collectionView.contentInset = UIEdgeInsetsMake(64.f+10.f, 10.f, 0, 0);
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCellIdentify];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_bottomView];
    _bottomView.size = (CGSize){SCREEN_WIDTH, 44.f};
    _bottomView.top = SCREEN_HEIGHT;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_bottomView addSubview:btn];
    btn.frame = _bottomView.bounds;
    [btn setTitle:@"退出编辑" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    [btn addTarget:self action:@selector(finishEdit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-10-2)/2.0, (SCREEN_WIDTH-10-1)/2.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.borderView.hidden = ![indexPath isEqual: self.seletedIndexPath];
    [cell updateCelWithTitle:_dataSource[indexPath.item] baseVC:self];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_seletedIndexPath isEqual:indexPath]) {
        _seletedIndexPath = nil;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        return;
    }
    if (!_seletedIndexPath) {
        _seletedIndexPath = indexPath;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
    else {
        [self exchangeItemIdex:indexPath];
    }
}

#pragma mark - Private

- (void)exchangeItemIdex:(NSIndexPath *)indexPath
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObjectsFromArray:_dataSource];
    
    NSMutableArray *orignalSection = temp;
    
    if (_collectionView.numberOfSections == 1) { // 单组
        [orignalSection exchangeObjectAtIndex:indexPath.item withObjectAtIndex:_seletedIndexPath.item];
    }
    else { // 多组
        NSUInteger countPerSection = [_collectionView numberOfItemsInSection:0];
        
        [orignalSection exchangeObjectAtIndex:indexPath.section*countPerSection+indexPath.item withObjectAtIndex:_seletedIndexPath.section*countPerSection+_seletedIndexPath.item];
    }
    _dataSource = temp.copy;
    
    // 执行交换动画
    [_collectionView performBatchUpdates:^{
        
        _collectionView.userInteractionEnabled = NO;
        
        [_collectionView moveItemAtIndexPath:self.seletedIndexPath toIndexPath:indexPath];
        [_collectionView moveItemAtIndexPath:indexPath toIndexPath:self.seletedIndexPath];
        
    } completion:^(BOOL finished) {
        
        self.seletedIndexPath = nil;
        [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
        _collectionView.userInteractionEnabled = YES;
    }];
}

#pragma mark - Public

- (void)beginEdit
{
    _isEditing = YES;
    NSArray *visibleCells = [_collectionView visibleCells];
    [visibleCells makeObjectsPerformSelector:NSSelectorFromString(@"startEditSwitchAnimation")];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.bottom = SCREEN_HEIGHT;
    }];
}

- (void)finishEdit
{
    _isEditing = NO;
    
    NSArray *visibleCells = [_collectionView visibleCells];
    [visibleCells makeObjectsPerformSelector:NSSelectorFromString(@"startEditSwitchAnimation")];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.top = SCREEN_HEIGHT;
    }];
}

@end
