//
//  CitySideViewController.m
//  Wegou
//
//  Created by 钟文锋 on 16/3/9.
//  Copyright © 2016年 vinfol. All rights reserved.
//

#import "CitySearchViewController.h"
#import "CityGroupsModel.h"
#import "CitySearchResultController.h"
#import "Masonry.h"

@interface CitySearchViewController()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CitySearchResultControllerDelegate>

@property (nonatomic, strong) UITableView *cityNameTableView;
@property (nonatomic, strong) UISearchBar *citySearchBar;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, copy) NSArray *cityGroupsModelArray;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) CitySearchResultController *citySearchResultController;

@end

@implementation CitySearchViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.citySearchBar];
    [self.view addSubview:self.cityNameTableView];
    [self.coverView addGestureRecognizer:self.tapGesture];
    [self.view addSubview:self.coverView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if ([self.delegate respondsToSelector:@selector(selectedCityName)]) {
        [self.delegate selectedCityName];
    }
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

#pragma mark - CitySearchResultControllerDelegate
- (void)didSelectedCell
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.citySearchBar resignFirstResponder];
    [self.citySearchResultController.view removeFromSuperview];
    self.citySearchBar.text = @"";
}


#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.coverView setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.coverView setHidden:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setHeight:64];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length) {
        self.citySearchResultController.searchText = searchText;
        [self.view addSubview:self.citySearchResultController.view];
        [self.citySearchResultController.view setHidden:NO];
    }else {
        [self.citySearchResultController.view setHidden:YES];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.citySearchBar resignFirstResponder];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    if ([self.navigationController.navigationBar isHidden]) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    }
}

#pragma mark - getters and setters
- (UITableView *)cityNameTableView
{
    if (!_cityNameTableView) {
        _cityNameTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 31*kAdaptPixel, kScreen_Width, kScreen_Height-33*kAdaptPixel)];
        [_cityNameTableView setBackgroundColor:[UIColor whiteColor]];
        _cityNameTableView.delegate = self;
        _cityNameTableView.dataSource = self;
        _cityNameTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _cityNameTableView;
}

- (UISearchBar *)citySearchBar
{
    if (!_citySearchBar) {
        _citySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30*kAdaptPixel)];
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

- (NSArray *)cityGroupsModelArray
{
    if (!_cityGroupsModelArray) {
        _cityGroupsModelArray = [CityGroupsModel getCityGroupModelArray];
    }
    return _cityGroupsModelArray;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 31*kAdaptPixel, kScreen_Width, kScreen_Height)];
        [_coverView setBackgroundColor:[UIColor blackColor]];
        _coverView.hidden = YES;
        _coverView.alpha = 0.5;
    }
    return _coverView;
}

- (CitySearchResultController *)citySearchResultController
{
    if (!_citySearchResultController) {
        _citySearchResultController = [[CitySearchResultController alloc] init];
        _citySearchResultController.delegate = self;
    }
    return _citySearchResultController;
}


@end
