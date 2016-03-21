//
//  NewsModel.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/17.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

//模型数组
+ (NSArray *)getNewsModelArray;
//标题数组
+ (NSArray *)getTitleArray;
@end
