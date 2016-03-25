//
//  NewsTableViewCell.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/22.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsArticleModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define k_TitleColor [UIColor blackColor];

@interface NewsTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *feed_titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImageView;


@end

@implementation NewsTableViewCell
#pragma mark - override methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(5*kAdaptPixel, 5*kAdaptPixel, 250*kAdaptPixel, 60*kAdaptPixel);
    self.feed_titleLabel.frame = CGRectMake(5*kAdaptPixel, 70*kAdaptPixel, 100*kAdaptPixel, 20*kAdaptPixel);
    self.timeLabel.frame = CGRectMake(180*kAdaptPixel, 70*kAdaptPixel, 70*kAdaptPixel, 20*kAdaptPixel);
    self.iconImageView.frame = CGRectMake(270*kAdaptPixel, 5*kAdaptPixel, 80*kAdaptPixel, 70*kAdaptPixel);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - private methods
/**有图片*/
- (void)initUI_1
{
    //标题
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.textColor = k_TitleColor;
    titleLbl.textAlignment = NSTextAlignmentLeft;
    titleLbl.numberOfLines = 2;
    titleLbl.font = [UIFont boldSystemFontOfSize:17*kAdaptPixel];
    _timeLabel = titleLbl;
    [self addSubview:titleLbl];
    
    //来源
    UILabel *sourceLbl = [[UILabel alloc] init];
    sourceLbl.textColor = [UIColor lightGrayColor];
    sourceLbl.textAlignment = NSTextAlignmentLeft;
    sourceLbl.numberOfLines = 1;
    sourceLbl.font = [UIFont boldSystemFontOfSize:14*kAdaptPixel];
    _feed_titleLabel = sourceLbl;
    [self addSubview:sourceLbl];
    
    //时间
    UILabel *timeLbl = [[UILabel alloc] init];
    timeLbl.textColor = [UIColor lightGrayColor];
    timeLbl.textAlignment = NSTextAlignmentLeft;
    timeLbl.numberOfLines = 1;
    timeLbl.font = [UIFont boldSystemFontOfSize:14*kAdaptPixel];
    _timeLabel = timeLbl;
    [self addSubview:timeLbl];
    
    //图片
    UIImageView *imgView = [[UIImageView alloc] init];
    _iconImageView = imgView;
    [self addSubview:imgView];
}

/**无图片*/
- (void)initUI_2
{
    
}

#pragma mark - getters and setters
- (void)setActicleModel:(NewsArticleModel *)acticleModel
{
    _acticleModel = acticleModel;
    self.titleLabel.text = acticleModel.title;
    self.feed_titleLabel.text = acticleModel.feed_title;
    self.timeLabel.text = acticleModel.time;
    
}

@end
