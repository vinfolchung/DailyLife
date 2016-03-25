//
//  NewsArticleModel.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/20.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(NSArray *modelArray);
@interface NewsArticleModel : NSObject<NSCoding>

/*
 "id": "zMNN3iu",
 "title": "JBL Pulse 2 review - CNET",
 "time": "02-18 17:00",
 "rectime": "02-18 17:15",
 "uts": 1455786911704,
 "feed_title": "CNET Reviews",
 "img": "http://aimg0.tuicool.com/zURJNj.jpg!middle",
 "abs": "",
 "cmt": 0,
 "st": 0,
 "go": 0
 
 */
@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,copy) NSString *rectime;

@property (nonatomic,copy) NSString *uts;

@property (nonatomic,copy) NSString *feed_title;

@property (nonatomic,copy) NSString *img;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

+ (instancetype)articleModelWithDictionary:(NSDictionary *)dic;

+ (void)articleModelGetDataWithURLString:(NSString *)URLString
                                  title:(NSString *)title
                             parameters:parameters
                           successBlock:(successBlock)successBlock;


@end
