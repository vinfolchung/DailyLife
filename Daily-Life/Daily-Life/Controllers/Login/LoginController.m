//
//  LoginController.m
//  DailyLife
//
//  Created by 钟文锋 on 16/3/8.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "LoginController.h"
#import "MainViewController.h"

@interface LoginController()
@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LoginController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - getters and setters
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _imageView.image = [UIImage imageNamed:@"login2"];
        _imageView.alpha = 0.7;
    }
    return _imageView;
}

@end
