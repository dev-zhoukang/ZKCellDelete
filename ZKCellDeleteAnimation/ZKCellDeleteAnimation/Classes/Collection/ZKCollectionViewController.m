

//
//  ZKCollectionViewController.m
//  ZKCellDeleteAnimation
//
//  Created by ZK on 16/10/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKCollectionViewController.h"
#import "ZKCollectionViewCell.h"

@interface ZKCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

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
    [cell updateCelWithTitle:_dataSource[indexPath.item] baseVC:self];
    return cell;
}

#pragma mark - Public

- (void)beginEdit
{
    _isEditing = YES;
    
    NSArray *visibleCells = [_collectionView visibleCells];
    [visibleCells makeObjectsPerformSelector:NSSelectorFromString(@"startEditSwitchAnimation")];
}

@end
