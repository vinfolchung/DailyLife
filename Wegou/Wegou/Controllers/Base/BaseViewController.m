//
//  BaseViewController.m
//  Daily-Life
//
//  Created by 钟文锋 on 16/3/8.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "BaseViewController.h"
#define NormalBackgroundColor [UIColor colorWithRed:26/255.0 green:31/255.0 blue:45/255.0 alpha:1.0f]

@interface BaseViewController()

@end

@implementation BaseViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavagationBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 * 添加导航条
 */
- (void)setupNavagationBar
{
    UINavigationItem * navigationItem = [[UINavigationItem alloc] init];
    //标题
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120*kAdaptPixel, 30*kAdaptPixel)];
    label.text = [self setNavigationItemTitle];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:19.0f*kAdaptPixel];
    label.textColor = [UIColor whiteColor];
    
    if (!self.navigationController) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, (44+20)*kAdaptPixel)];
        navigationBar.translucent = NO;
        [navigationBar setBarTintColor:NormalBackgroundColor];
        [navigationBar pushNavigationItem:navigationItem animated:YES];
        navigationItem.titleView = label;
        navigationBar.layer.masksToBounds = YES;
        [self.view addSubview:navigationBar];
    }else {
        self.navigationController.navigationBar.translucent = NO;
        [self.navigationController.navigationBar setBarTintColor:NormalBackgroundColor];
        self.navigationItem.titleView = label;
    }
    
    //有返回按钮
    if (self.isBackBarButtonItem) {
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onBackBarButtonItem:)];
        if (!self.navigationController) {
            navigationItem.leftBarButtonItem = backBarButtonItem;
        }else {
            self.navigationItem.leftBarButtonItem = backBarButtonItem;
        }
    }else {
        if (self.navigationController) {
            self.navigationItem.leftBarButtonItem = [self setLeftBarButtonItem];
            self.navigationItem.rightBarButtonItem = [self setRightBarButtonItem];
        }else {
            navigationItem.leftBarButtonItem = [self setLeftBarButtonItem];
            navigationItem.rightBarButtonItem = [self setRightBarButtonItem];
        }
    }
}

#pragma override methods
- (NSString*)setNavigationItemTitle
{
    return @"";
}
- (UIBarButtonItem *)setLeftBarButtonItem
{
    return nil;
}
- (UIBarButtonItem *)setRightBarButtonItem
{
    return nil;
}

#pragma mark - event respond
- (void)onBackBarButtonItem:(id)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end