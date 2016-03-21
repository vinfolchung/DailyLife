//
//  MainViewController.m
//  Daily-Life
//
//  Created by 钟文锋 on 16/3/9.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "MainViewController.h"
#import "CitySearchViewController.h"
#import "BaseNavigationViewController.h"
#import "TitleView.h"
#import "TitleLabel.h"
#import "NewsTableViewController.h"

#import "ContentCollectionViewCell.h"
#import "Masonry.h"
#import "MainCategoryView.h"
#import "NewsModel.h"
#import "UICollectionViewFlowLayout+FullItem.h"
#define meBtnBackgroundColor [UIColor colorWithRed:232/255.0 green:240/255.0 blue:195/255.0 alpha:0.2]

@interface MainViewController()<CitySearchVCDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MainCategoryViewDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *meBtn;
@property (nonatomic, strong) BaseNavigationViewController *citySideNVC;
@property (nonatomic, strong) CitySearchViewController *citySideVC;
//@property (nonatomic, strong) UIScrollView *contentScrollView;
//@property (nonatomic, strong) TitleView *titleView;
//记录上一次label的tag
//@property (nonatomic, assign) NSInteger lastIndex;

//使用CategoryView
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) MainCategoryView *categoryView;
@property (nonatomic, copy) NSArray *titlesArray;


@end

@implementation MainViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainView = mainView;
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[ContentCollectionViewCell class] forCellWithReuseIdentifier:@"ContentCollectionViewCell"];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    //catergoryView
    MainCategoryView *catergoryView = [MainCategoryView new];
    _categoryView = catergoryView;
    catergoryView.titles = self.titlesArray;
    catergoryView.scrollView = mainView;
    catergoryView.delegate = self;
    catergoryView.backgroundColor = NavBackgroundColor;
    catergoryView.itemSpacing = 20.0f;
    //开启缩放
    catergoryView.scaleEnable = YES;
    catergoryView.titleColorChangeEnable = YES;
    //设置缩放等级
    catergoryView.scaleRatio = 1.3f;
    catergoryView.titleColor = [UIColor whiteColor];
    catergoryView.titleSelectColor = [UIColor cyanColor];
    //开启点击item滑动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = YES;
    [self.view addSubview:catergoryView];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(65*kAdaptPixel);
        make.height.equalTo(@35);
        make.bottom.equalTo(mainView.mas_top);
    }];
}

#pragma mark - override methods
- (NSString *)setNavigationItemTitle
{
    return @"WE购";
}

- (UIBarButtonItem *)setLeftBarButtonItem
{
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.meBtn];
    return leftBarBtn;
}

- (UIBarButtonItem *)setRightBarButtonItem
{
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.cityBtn];
    return rightBarBtn;
}

#pragma mark - CitySearchVCDelegate
- (void)selectedCityName
{
    [self.cityBtn setTitle:[UserDefaultsUtil getSelectedCityName] forState:UIControlStateNormal];
    [self.cityBtn reloadInputViews];
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

/**监听item点击*/
- (void)catergoryView:(MainCategoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%zd个item", indexPath.item);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - event respond
- (void)onCityBtn:(id)sender
{
    [self presentViewController:self.citySideNVC animated:YES completion:nil];
}

- (void)onMeBtn:(id)sender
{
    
}

#pragma mark - getters and setters
- (UIButton *)cityBtn
{
    if (!_cityBtn) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityBtn.frame = CGRectMake(0, 0, 100*kAdaptPixel, 30*kAdaptPixel);
        if ([UserDefaultsUtil getSelectedCityName] == nil) {
            [self.cityBtn setTitle:@"佛山" forState:UIControlStateNormal];
        }else {
            [self.cityBtn setTitle:[UserDefaultsUtil getSelectedCityName] forState:UIControlStateNormal];
        }
        _cityBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:16*kAdaptPixel];
        [_cityBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _cityBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_cityBtn setImage:[UIImage imageNamed:@"btn_changeCity"] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(onCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityBtn;
}

- (UIButton *)meBtn
{
    if (!_meBtn) {
        _meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _meBtn.frame = CGRectMake(0, 0, 30*kAdaptPixel, 30*kAdaptPixel);
        [_meBtn setImage:[UIImage imageNamed:@"nav_me"] forState:UIControlStateNormal];
        [_meBtn addTarget:self action:@selector(onMeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _meBtn;
}

- (CitySearchViewController *)citySideVC
{
    if (!_citySideVC) {
        _citySideVC = [[CitySearchViewController alloc] init];
        _citySideVC.delegate = self;
    }
    return _citySideVC;
}

- (BaseNavigationViewController *)citySideNVC
{
    if (!_citySideNVC) {
        _citySideNVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.citySideVC];
    }
    return _citySideNVC;
}

- (NSArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray = [NewsModel getTitleArray];
    }
    return _titlesArray;
}


@end
