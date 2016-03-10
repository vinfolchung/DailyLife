//
//  CitySideViewController.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/9.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "CitySearchViewController.h"
#import "CityGroupsModel.h"

@interface CitySearchViewController()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *cityNameTableView;
@property (nonatomic, strong) UISearchBar *citySearchBar;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, copy) NSArray *cityGroupsModelArray;

@end

@implementation CitySearchViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.citySearchBar];
    [self.view addSubview:self.cityNameTableView];
    [self.view addGestureRecognizer:self.tapGesture];
    self.cityGroupsModelArray = [CityGroupsModel getCityGroupModelArray];
}

#pragma mark - override methods
- (NSString *)setNavigationItemTitle
{
    return @"切换城市";
}

- (UIBarButtonItem *)setLeftBarButtonItem
{
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_close"]
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(onLeftBarBtn:)];
    [leftBarBtn setTintColor:[UIColor whiteColor]];
    return leftBarBtn;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroupsModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.cityGroupsModelArray objectAtIndex:section] cities] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CityGroupsModel *cityGroupsModel = [self.cityGroupsModelArray objectAtIndex:indexPath.section];
    cell.textLabel.text = cityGroupsModel.cities[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CityGroupsModel *cityGroupsModel = [self.cityGroupsModelArray objectAtIndex:section];
    return cityGroupsModel.title;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityGroupsModel *cityGroupsModel = [self.cityGroupsModelArray objectAtIndex:indexPath.section];
    [UserDefaultsUtil saveSelectedCityName:cityGroupsModel.cities[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - event respond
- (void)onLeftBarBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTapGesture:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - getters and setters
- (UITableView *)cityNameTableView
{
    if (!_cityNameTableView) {
        _cityNameTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 34*kAdaptPixel, kScreen_Width, kScreen_Height-34*kAdaptPixel)];
        [_cityNameTableView setBackgroundColor:[UIColor whiteColor]];
        _cityNameTableView.delegate = self;
        _cityNameTableView.dataSource = self;
    }
    return _cityNameTableView;
}

- (UISearchBar *)citySearchBar
{
    if (!_citySearchBar) {
        _citySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 2, kScreen_Width, 32*kAdaptPixel)];
        _citySearchBar.placeholder = @"请输入要搜索的城市名";
        _citySearchBar.delegate = self;
    }
    return _citySearchBar;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    }
    return _tapGesture;
}

@end
