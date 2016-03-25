//
//  NewsTableViewCell.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsArticleModel;
@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) NewsArticleModel *acticleModel;

@end
