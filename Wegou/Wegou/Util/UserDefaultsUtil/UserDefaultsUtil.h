//
//  UserDefaultsUtil.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/10.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtil : NSObject

/**
 * 获取和保存选择的城市名
 */
+ (NSString *)getSelectedCityName;
+ (void)saveSelectedCityName:(NSString *)cityName;

@end
