//
//  ContentCollectionViewCell.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/20.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "ContentCollectionViewCell.h"
#import "NewsTableViewController.h"

@interface ContentCollectionViewCell()

@property (nonatomic, strong) NewsTableViewController *newsTableVC;

@end

@implementation ContentCollectionViewCell

#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.newsTableVC.view.frame = self.bounds;
}

- (void)initUI
{
    [self addSubview:self.newsTableVC.view];
}

#pragma mark - getters and setters
- (NewsTableViewController *)newsTableVC
{
    if (!_newsTableVC) {
        _newsTableVC = [[NewsTableViewController alloc] init];
        _newsTableVC.view.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0];
    }
    return _newsTableVC;
}

@end
