//
//  BaseViewController.m
//  Daily-Life
//
//  Created by 钟文锋 on 16/3/8.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 * 添加导航条
 */
- (void)setupNavagationBar
{
    UINavigationItem * navigationItem = [[UINavigationItem alloc] init];
    
    if (!self.navigationController) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 44+20)];
        [navigationBar pushNavigationItem:navigationItem animated:YES];
        navigationBar.layer.masksToBounds = YES;
        [self.view addSubview:navigationBar];
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120*kAdaptPixel, 308*kAdaptPixel)];
    label.text = [self navigationItemTitle];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18.0f*kAdaptPixel];
    label.textColor = [UIColor whiteColor];
    if (!self.navigationController) {
        navigationItem.titleView = label;
    }else {
        self.navigationItem.titleView = label;
    }
    
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
            self.navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
            self.navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
        }else {
            navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
            navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
        }
    }
}

#pragma override methods

- (NSString*)navigationItemTitle
{
    return @"";
}
- (UIBarButtonItem *)getLeftBarButtonItem
{
    return nil;
}
- (UIBarButtonItem *)getRightBarButtonItem
{
    return nil;
}

@end
