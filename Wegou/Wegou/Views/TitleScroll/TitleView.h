//
//  TitleView.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/18.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate;

@interface TitleView : UIScrollView

@property (nonatomic, assign) NSInteger titleCount;
@property (nonatomic, weak) id<TitleViewDelegate> titleViewDelegete;

@end

@protocol TitleViewDelegate <NSObject>
@optional

- (void)titleLabelOnTapped:(UITapGestureRecognizer *)recognizer;

@end
