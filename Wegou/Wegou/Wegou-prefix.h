//
//  Wegou-prefix.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/9.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#ifndef Wegou_prefix_h
#define Wegou_prefix_h
#import "UIView+PlaceSize.h"
#import "UserDefaultsUtil.h"

//屏幕适配,以iPhone6为基准
#define kAdaptPixel (kScreen_Width / 375.0f)

// 屏幕的宽、高
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

//导航条颜色
#define NavBackgroundColor [UIColor colorWithRed:26/255.0 green:31/255.0 blue:45/255.0 alpha:1.0f]
#endif /* Wegou_prefix_h */
