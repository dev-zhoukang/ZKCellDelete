

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
@property (nonatomic, strong) UIView *bottomView;

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
