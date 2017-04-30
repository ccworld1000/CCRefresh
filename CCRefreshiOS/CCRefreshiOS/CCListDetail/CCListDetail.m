//
//  CCListDetail.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/30/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCListDetail.h"
#import "UIViewController+Method.h"

#import "CCChiBaoZiHeader.h"
#import "CCChiBaoZiFooter.h"
#import "CCChiBaoZiFooter2.h"
#import "CCDIYHeader.h"
#import "CCDIYAutoFooter.h"
#import "CCDIYBackFooter.h"

static const CGFloat CCDuration = 2.0;

#define CCRandomData [NSString stringWithFormat:@"random data ---%d", arc4random_uniform(1000000)]


@interface CCListDetail ()

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation CCListDetail

#pragma mark - 示例代码
#pragma mark UITableView + 下拉刷新 默认
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.CCHeader = [CCRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.CCHeader beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 动画图片
- (void)example02
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.CCHeader = [CCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [self.tableView.CCHeader beginRefreshing];
}

#pragma mark UITableView + 下拉刷新 隐藏时间
- (void)example03
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    CCRefreshNormalHeader *header = [CCRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.CCHeader = header;
}

#pragma mark UITableView + 下拉刷新 隐藏状态和时间
- (void)example04
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    CCChiBaoZiHeader *header = [CCChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.tableView.CCHeader = header;
}

#pragma mark UITableView + 下拉刷新 自定义文字
- (void)example05
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    CCRefreshNormalHeader *header = [CCRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:CCRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:CCRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:CCRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.CCHeader = header;
}

#pragma mark UITableView + 下拉刷新 自定义刷新控件
- (void)example06
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.CCHeader = [CCDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.CCHeader beginRefreshing];
}

#pragma mark UITableView + 上拉刷新 默认
- (void)example11
{
    [self example01];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.CCFooter = [CCRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark UITableView + 上拉刷新 动画图片
- (void)example12
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.CCFooter = [CCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark UITableView + 上拉刷新 隐藏刷新状态的文字
- (void)example13
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    CCChiBaoZiFooter *footer = [CCChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.tableView.CCFooter = footer;
}

#pragma mark UITableView + 上拉刷新 全部加载完毕
- (void)example14
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    self.tableView.CCFooter = [CCRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    // 其他
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(reset)];
}

- (void)reset
{
    [self.tableView.CCFooter setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //    [self.tableView.CCFooter beginRefreshing];
    [self.tableView.CCFooter resetNoMoreData];
}

#pragma mark UITableView + 上拉刷新 禁止自动加载
- (void)example15
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    CCRefreshAutoNormalFooter *footer = [CCRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    
    // 设置footer
    self.tableView.CCFooter = footer;
}

#pragma mark UITableView + 上拉刷新 自定义文字
- (void)example16
{
    [self example01];
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    CCRefreshAutoNormalFooter *footer = [CCRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"Click or drag up to refresh" forState:CCRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:CCRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:CCRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    self.tableView.CCFooter = footer;
}

#pragma mark UITableView + 上拉刷新 加载后隐藏
- (void)example17
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
    self.tableView.CCFooter = [CCRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
}

#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
- (void)example18
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.CCFooter = [CCRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.tableView.CCFooter.ignoredScrollViewContentInsetBottom = 30;
}

#pragma mark UITableView + 上拉刷新 自动回弹的上拉02
- (void)example19
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    self.tableView.CCFooter = [CCChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    self.tableView.CCFooter.automaticallyChangeAlpha = YES;
}

#pragma mark UITableView + 上拉刷新 自定义刷新控件(自动刷新)
- (void)example20
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.CCFooter = [CCDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark UITableView + 上拉刷新 自定义刷新控件(自动回弹)
- (void)example21
{
    [self example01];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.CCFooter = [CCDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
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
