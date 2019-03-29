//
//  ADSearchBarVC.m
//  单列封装
//
//  Created by 王奥东 on 16/6/7.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADSearchBarVC.h"
//#import "ADSearch.h"

#import "ResultTableViewController.h"

@interface ADSearchBarVC ()<UISearchResultsUpdating,UISearchControllerDelegate>

@property (strong,nonatomic) NSMutableArray  *dataList;


@property (nonatomic, strong) UISearchController *searchC;


@property (nonatomic, strong) ResultTableViewController *resultTableView;

@end

@implementation ADSearchBarVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickReturn)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    self.resultTableView = [[ResultTableViewController alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout =UIRectEdgeNone;
    
    self.searchC = [[UISearchController alloc] initWithSearchResultsController:self.resultTableView];
    
    self.searchC.searchBar.frame = CGRectMake(0, 0, WIDTH, 44);
    
    
//    self.tableView.tableHeaderView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 44);
    
//    self.tableView.sectionHeaderHeight = 44;
    self.tableView.tableHeaderView = self.searchC.searchBar;
    
    NSLog(@"%@",self.tableView.tableHeaderView);
    
    
//    self.searchC.searchBar.backgroundColor = [UIColor redColor];
    self.searchC.delegate = self;
    self.searchC.searchResultsUpdater = self;
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld-FlyElephant",(long)i]];
    }
    
    
}
-(void)clickReturn{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(void)willPresentSearchController:(UISearchController *)searchController {
    self.navigationController.navigationBar.translucent = YES;
}

-(void)willDismissSearchController:(UISearchController *)searchController {
    self.navigationController.navigationBar.translucent = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}




- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    
    // 谓词的包含语法
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchC.searchBar.text];
    
    //过滤数据
    NSArray *relustArray = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    
    NSLog(@"%@",relustArray);
    
    self.searchC.edgesForExtendedLayout = UIRectEdgeNone;//不加的话，UISearchBar返回后会上移
    
    self.resultTableView.searchList = relustArray;
    
    [self.resultTableView.tableView reloadData];
    
}


@end
