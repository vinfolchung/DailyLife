//
//  NewsArticleModel.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/20.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "NewsArticleModel.h"
#import "SVProgressHUD.h"
#import "HTTPManager.h"
#import "NewsArticleManager.h"

@implementation NewsArticleModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)articleModelWithDictionary:(NSDictionary *)dic{
    
    return [[self alloc]initWithDictionary:dic];
}

/**编码*/
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.rectime forKey:@"rectime"];
    [aCoder encodeObject:self.uts forKey:@"uts"];
    [aCoder encodeObject:self.feed_title forKey:@"feed_title"];
    [aCoder encodeObject:self.img forKey:@"img"];
}

/**译码*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.rectime = [aDecoder decodeObjectForKey:@"rectime"];
        self.uts = [aDecoder decodeObjectForKey:@"uts"];
        self.feed_title = [aDecoder decodeObjectForKey:@"feed_title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
    }
    return self;
}

+ (void)articleModelGetDataWithURLString:(NSString *)URLString
                                   title:(NSString *)title
                              parameters:parameters
                            successBlock:(successBlock)successBlock{
    
    [SVProgressHUD show];
    [HTTPManager getWithURLString:URLString
                        parameter:parameters
                         progress:nil
                          success:^(id responseObject) {
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        NSArray *articles = responseObjectDic[@"articles"];
        NSMutableArray *num = [NSMutableArray array];
        for (NSDictionary *dic in articles) {
            NewsArticleModel *articleModel = [self articleModelWithDictionary:dic];
            [num addObject:articleModel];
        }
        //默认是热门加载
        if ([title isEqualToString:@"热门"]) {
            [NewsArticleManager addArticleModel:num.copy];
        }
        successBlock(num.copy);
        [SVProgressHUD dismiss];
    }
                          failure:^(NSError *error) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"error"] status:@"加载失败"];
        NSLog(@"%@",error);
    }];
}


@end
