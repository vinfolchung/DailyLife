//
//  MainViewController.m
//  Daily-Life
//
//  Created by 钟文锋 on 16/3/9.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "MainViewController.h"
#import "CitySideViewController.h"
#import "BaseNavigationViewController.h"
#define meBtnBackgroundColor [UIColor colorWithRed:232/255.0 green:240/255.0 blue:195/255.0 alpha:0.2]

@interface MainViewController()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) UIButton *meBtn;
@property (nonatomic, strong) BaseNavigationViewController *citySideNVC;
@property (nonatomic, strong) CitySideViewController *citySideVC;
@end

@implementation MainViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - override methods
- (NSString *)setNavigationItemTitle
{
    return @"WE购";
}

- (UIBarButtonItem *)setLeftBarButtonItem
{
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.cityBtn];
    return leftBarBtn;
}

- (UIBarButtonItem *)setRightBarButtonItem
{
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.meBtn];
    return rightBarBtn;
}

#pragma mark - private method



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
        _cityBtn.frame = CGRectMake(0, 30*kAdaptPixel, 50*kAdaptPixel, 30*kAdaptPixel);
        [_cityBtn setTitle:@"广州" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0*kAdaptPixel];
        [_cityBtn addTarget:self action:@selector(onCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityBtn;
}

- (UIButton *)meBtn
{
    if (!_meBtn) {
        _meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _meBtn.frame = CGRectMake(kScreen_Width - 35*kAdaptPixel, 30*kAdaptPixel, 30*kAdaptPixel, 30*kAdaptPixel);
        [_meBtn setImage:[UIImage imageNamed:@"nav_me"] forState:UIControlStateNormal];
        [_meBtn addTarget:self action:@selector(onMeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _meBtn;
}

- (CitySideViewController *)citySideVC
{
    if (!_citySideVC) {
        _citySideVC = [[CitySideViewController alloc] init];
    }
    return _citySideVC;
}

- (BaseNavigationViewController *)CitySideNVC
{
    if (!_citySideNVC) {
        _citySideNVC = [[BaseNavigationViewController alloc] initWithRootViewController:self.citySideVC];
    }
    return _citySideNVC;
}

@end
