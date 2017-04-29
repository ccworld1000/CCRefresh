//
//  CCDIYTab2.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/30/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCDIYTab2.h"

#import "CCChiBaoZiHeader.h"
#import "CCChiBaoZiFooter.h"
#import "CCChiBaoZiFooter2.h"
#import "CCDIYHeader.h"
#import "CCDIYAutoFooter.h"
#import "CCDIYBackFooter.h"

static const CGFloat CCDuration = 2.0;

#define CCRandomData [NSString stringWithFormat:@"random data ---%d", arc4random_uniform(1000000)]


@interface CCDIYTab2 ()

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation CCDIYTab2

- (void) loadingUI {
#pragma mark UITableView + 下拉刷新 隐藏状态和时间
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.CCHeader = [CCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.CCHeader beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:CCRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.CCHeader endRefreshing];
    });
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:CCRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.CCFooter endRefreshing];
    });
}

#pragma mark 加载最后一份数据
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:CCRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [tableView.CCFooter endRefreshingWithNoMoreData];
    });
}

#pragma mark 只加载一次数据
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:CCRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CCDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        tableView.CCFooter.hidden = YES;
    });
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:CCRandomData];
        }
    }
    return _data;
}

#pragma mark - 其他
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self loadingUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row]];
    
    return cell;
}

@end
