//
//  HTTPManager.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "HTTPManager.h"
#import "AFNetworking.h"

@implementation HTTPManager

+ (void)getWithURLString:(NSString *)URLString
               parameter:(NSDictionary *)parameter
                progress:(void (^)(NSProgress *))progress
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
    [manager.requestSerializer setValue:userAgent forKey:@"User-Agent"];
    
    //判断是否登录 未实现 默认未登陆
//    if () {
//        
//    }else {
//        
//    }
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
    
    [manager GET:URLString
      parameters:parameter
        progress:^(NSProgress * _Nonnull downloadProgress) {
            if(progress) {
                progress(downloadProgress);
            }
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (success) {
                 success(responseObject);
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
                 failure(error);
             }
         }];
}

+ (void)postWithURLString:(NSString *)URLString
                parameter:(NSDictionary *)parameter
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/2.15.0",[[UIDevice currentDevice] name]];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"0.0.0.0" password:@"tuicool"];
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:URLString
       parameters:parameter
         progress:^(NSProgress * _Nonnull uploadProgress) {
             if (progress) {
                 progress(uploadProgress);
             }
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              if (success) {
                  success(responseObject);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (failure) {
                  failure(error);
              }
          }];
    
}


@end
