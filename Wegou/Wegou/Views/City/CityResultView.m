//
//  CityResultView.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/11.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "CityResultView.h"
#import "CitiesModel.h"

@interface CityResultView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *resultView;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@end

@implementation CityResultView
#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.resultView];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    CitiesModel *cityModel = [self.searchResultArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cityModel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCell)]) {
        [self.delegate didSelectedCell];
    }
    CitiesModel *cityModel = [self.searchResultArray objectAtIndex:indexPath.row];
    [UserDefaultsUtil saveSelectedCityName:cityModel.name];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)resultView
{
    if (!_resultView) {
        _resultView = [[UITableView alloc] initWithFrame:self.frame];
        _resultView.delegate = self;
        _resultView.dataSource = self;
    }
    return _resultView;
}

- (NSMutableArray *)searchResultArray
{
    if (!_searchResultArray) {
        _searchResultArray = [[NSMutableArray alloc] init];
        NSArray *citiesModelArray = [CitiesModel getCitiesModelArray];
        for (CitiesModel *citieModel in citiesModelArray) {
            if ([citieModel.pinYin containsString:self.searchText] || [citieModel.pinYinHead containsString:self.searchText]) {
                [_searchResultArray addObject:citieModel];
            }
        }
        [self.resultView reloadData];
    }
    return _searchResultArray;
}

- (NSString *)searchText
{
    if (!_searchText) {
        [_searchText lowercaseString];
    }
    return _searchText;
}
@end
