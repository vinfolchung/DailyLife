//
//  CitySearchResultController.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/10.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "CitySearchResultController.h"

@interface CitySearchResultController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *searchResultView;
@end

@implementation CitySearchResultController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark UITableViewDataSource,UITableViewDelegate


#pragma mark - getters and setters
- (UITableView *)searchResultView
{
    if (!_searchResultView) {
        _searchResultView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    }
    return _searchResultView;
}




@end
