//
//  NewsArticleManager.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "NewsArticleManager.h"
#import "NewsArticleModel.h"
#import "FMDB.h"
static FMDatabase *_db;

@implementation NewsArticleManager

+ (void)initialize
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"homeData.db"];
    //创建数据库
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    if (![_db open]) {
        return;
    }
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS article_deal(id integer PRIMARY KEY, deal blob NOT NULL, deal_id text NOT NULL);"];
}

+ (void)addArticleModel:(NewsArticleModel *)model
{
    //归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [_db executeUpdateWithFormat:@"INSERT INTO article_deal(deal,deal_id) VALUES(%@,%@);",data,model.id];
}

+ (void)deleteArticleModel:(NewsArticleModel *)model
{
    [_db executeUpdateWithFormat:@"DELETE FROM article_deal WHERE deal_id=%@", model.id];
}

+ (void)addArticleModelArray:(NSArray *)modelArray
{
    [_db executeUpdate:@"DELETE FROM article_deal;"];
    for (NewsArticleModel *model in modelArray) {
        [self addArticleModel:model];
    }
}

/**获取全部文章数据*/
+ (NSArray *)getAllArticles
{
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM article_deal;"];
    //3. 获取数据 --> 获取模型的二进制数据  --> 还原成模型 --> 并且添加到数组中返回
    NSMutableArray *tempArray = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set objectForColumnName:@"deal"];
        NewsArticleModel *dealModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tempArray addObject:dealModel];
    }
    return tempArray;
}

@end
