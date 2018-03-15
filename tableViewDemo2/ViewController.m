//
//  ViewController.m
//  tableViewDemo2
//
//  Created by PatrickY on 2018/3/15.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
NSString *const cellIdentifier = @"cellIdentifier";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>
@property (nonatomic, strong) NSArray                           *teamList;
@property (nonatomic, strong) NSMutableArray                    *teamListFilter;

@end

@implementation ViewController {
    UITableView                                                 *_tableView;
    UISearchController                                          *_searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"plist"];
    _teamList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //查询
    [self filterContentForSearchText:@"" scope:-1];
    
    //UISearchController
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //更新搜索结果
    _searchController.searchResultsUpdater = self;
    //背景灰色
    _searchController.dimsBackgroundDuringPresentation = false;
    //搜索范围栏按钮
    _searchController.searchBar.scopeButtonTitles = @[@"中文",@"英文"];
    //delegate
    _searchController.searchBar.delegate = self;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    //搜索框放在表头
    _tableView.tableHeaderView = _searchController.searchBar;
    [_searchController.searchBar sizeToFit];
    
    [self.view addSubview:_tableView];
    
}

//搜索方法
- (void)filterContentForSearchText:(NSString *)searchText scope:(NSUInteger)scope {
    
    if ([searchText length] == 0) {
        //查询所有
        _teamListFilter = [NSMutableArray arrayWithArray:_teamList];
        return;
    }
    //谓词
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    switch (scope) {
        case 0://中文
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
            tempArray = [_teamList filteredArrayUsingPredicate:scopePredicate];
            _teamListFilter = [NSMutableArray arrayWithArray:tempArray];
            break;
        case 1://英文
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@", searchText];
            tempArray = [_teamList filteredArrayUsingPredicate:scopePredicate];
            _teamListFilter = [NSMutableArray arrayWithArray:tempArray];
            break;
        default://所有
            _teamListFilter = [NSMutableArray arrayWithArray:_teamList];
            break;
    }
    
}

#pragma UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _teamListFilter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCell *cell = [[DemoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *dict = _teamListFilter[row];
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = dict[@"image"];
    
    NSString *imageName = [[NSString alloc] initWithFormat:@"%@.png",dict[@"image"]];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma  UISearchBarDelegate, UISearchResultsUpdating
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateSearchResultsForSearchController:_searchController];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = searchController.searchBar.text;
    
    //查询
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [_tableView reloadData];
    
}

@end
