//
//  CityResultView.h
//  Wegou
//
//  Created by 钟文锋 on 16/3/11.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityResultViewDelegate;

@interface CityResultView : UIView

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, weak) id<CityResultViewDelegate> delegate;

@end

@protocol CityResultViewDelegate <NSObject>
@optional
- (void)didSelectedCell;

@end