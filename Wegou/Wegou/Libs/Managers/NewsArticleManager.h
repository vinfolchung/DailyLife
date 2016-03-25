//
//  NewsArticleManager.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsArticleModel;
@interface NewsArticleManager : NSObject

/**
 *  删除一个模型
 *
 *  @param model
 */
+ (void)deleteArticleModel:(NewsArticleModel *)model;
/**
 *  添加一个模型
 *
 *  @param model
 */
+ (void)addArticleModel:(NewsArticleModel *)model;
/**
 *  添加一组数据
 *
 *  @param modelArray
 */
+ (void)addArticleModelArray:(NSArray *)modelArray;
/**
 *  获取全部数据
 *
 *  @return 数据
 */
+ (NSArray *)getAllArticles;


@end
