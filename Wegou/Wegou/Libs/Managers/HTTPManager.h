//
//  HTTPManager.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPManager : NSObject

+ (void)getWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter
               progress:(void(^)(NSProgress *progress))progress
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;

+ (void)postWithURLString:(NSString *)URLString
               parameter:(NSDictionary *)parameter
                progress:(void(^)(NSProgress *progress))progress
                 success:(void(^)(id responseObject))success
                 failure:(void(^)(NSError *error))failure;

@end
