//
//  TitleLabel.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/18.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:19*kAdaptPixel];
        self.scale = 0.0;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    //当scale=1  有最大缩放量  同时颜色也是最深的
    _scale = scale;
    
    //红色的变化 随着scale改变颜色深浅
    [self setTextColor:[UIColor colorWithRed:scale green:120.0/255.0 blue:180.0/255.0 alpha:1]];
    //代表默认状态下的label的大小
    CGFloat minScale = 0.7;
    
    CGFloat trueScale = minScale + (1 - minScale)*scale;
    //控制label的缩放  通过scale参数
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}


@end
