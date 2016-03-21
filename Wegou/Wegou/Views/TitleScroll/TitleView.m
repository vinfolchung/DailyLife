//
//  TitleView.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/18.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "TitleView.h"
#import "NewsModel.h"
#import "TitleLabel.h"

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTitleLabel];
        self.backgroundColor = NavBackgroundColor;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)addTitleLabel
{
    NSArray *newsModelArray = [NewsModel getNewsModelArray];
    _titleCount = newsModelArray.count;
    for (int i = 0; i<_titleCount; i++) {
        NewsModel *newsModel = [newsModelArray objectAtIndex:i];
        CGFloat label_W = 60*kAdaptPixel;
        CGFloat label_H = 40*kAdaptPixel;
        CGFloat label_X = i*label_W;
        CGFloat label_Y = 0;
        
        TitleLabel *label = [[TitleLabel alloc] initWithFrame:CGRectMake(label_X, label_Y, label_W, label_H)];
        label.text = newsModel.title;
        [self addSubview:label];
        label.tag = i;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelOnTapped:)]];
    }
    self.contentSize = CGSizeMake(60*kAdaptPixel*_titleCount, 0);
}

- (void)labelOnTapped:(UITapGestureRecognizer *)recognizer
{
    if ([self.titleViewDelegete respondsToSelector:@selector(titleLabelOnTapped:)]) {
        [self.titleViewDelegete titleLabelOnTapped:recognizer];
    }
}
@end
