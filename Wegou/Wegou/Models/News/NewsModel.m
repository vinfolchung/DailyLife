//
//  NewsModel.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/17.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSArray *)getNewsModelArray
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"titleArray.plist" ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in plistArray) {
        NewsModel *newsModel = [[NewsModel alloc] init];
        newsModel.title = [dict objectForKey:@"title"];
        newsModel.url = [dict objectForKey:@"urlstring"];
        [modelArray addObject:newsModel];
    }
    return modelArray;
}

+ (NSArray *)getTitleArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSArray *titleArray = [[NSArray alloc] init];
    for (int i = 0; i<[self getNewsModelArray].count; i++) {
        NewsModel *model= [[self getNewsModelArray] objectAtIndex:i];
        [temp addObject:model.title];
    }
    titleArray = temp.copy;
    return titleArray;
}

@end
