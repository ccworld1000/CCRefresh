//
//  CCList.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/30/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCList.h"
#import "CCExample.h"
#import "CCListDetail.h"
#import <CCRefresh/CCRefresh.h>

static NSString *const CCExample00 = @"UITableView + Pull-down refresh";
static NSString *const CCExample10 = @"UITableView + Pull-up refresh";

@interface CCList ()

@property (strong, nonatomic) UIView *switchView;
@property (nonatomic) BOOL isChinese;
@property (strong, nonatomic) NSMutableArray *examples;

@end

@implementation CCList

- (void) loadingUI {
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.CCHeader= [CCRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.CCHeader endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.CCHeader.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.CCFooter = [CCRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.CCFooter endRefreshing];
        });
    }];
}

- (void) setIsChinese:(BOOL)isChinese {
    _isChinese = isChinese;
    
    [self.examples removeAllObjects];
    self.examples = nil;
    
    [self.tableView reloadData];
}

- (NSMutableArray *)examples
{
    if (!_examples) {
        CCExample *exam0 = [[CCExample alloc] init];
        exam0.header = CCExample00;
        exam0.vcClass = [CCListDetail class];
        
        if (self.isChinese) {
            exam0.titles = @[@"默认", @"动画图片", @"隐藏时间", @"隐藏状态和时间", @"自定义文字", @"自定义刷新控件"];
        } else {
            exam0.titles = @[@"default", @"animated picture", @"hidden time", @"hidden state and time", @"custom text", @"custom refresh control"];
        }
        
        
        exam0.methods = @[@"example01", @"example02", @"example03", @"example04", @"example05", @"example06"];
        
        CCExample *exam1 = [[CCExample alloc] init];
        exam1.header = CCExample10;
        exam1.vcClass = [CCListDetail class];
        
        if (self.isChinese) {
            exam1.titles = @[@"默认", @"动画图片", @"隐藏刷新状态的文字", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏", @"自动回弹的上拉01", @"自动回弹的上拉02", @"自定义刷新控件(自动刷新)", @"自定义刷新控件(自动回弹)"];
        } else {
            exam1.titles = @[@"default", @"animated picture", @"hidden refresh status text", @"all loaded", @"disable automatic loading", @"custom text", @"hidden after loading", @"automatic rebound pull up 01", @"automatic rebound pull up 02", @"custom refresh control (auto refresh)", @"custom refresh control (automatic rebound)"];
        }
        
        
        exam1.methods = @[@"example11", @"example12", @"example13", @"example14", @"example15", @"example16", @"example17", @"example18", @"example19", @"example20", @"example21"];

        self.examples = [NSMutableArray arrayWithArray: @[exam0, exam1]];
    }
    return _examples;
}

- (void) switchLanguageHandle : (UISegmentedControl *) s {
    self.isChinese = s.selectedSegmentIndex;
}

- (UIView *) switchView {
    if (!_switchView) {
        _switchView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 200, 20, 200, 60)];;
        _switchView.backgroundColor = [UIColor purpleColor];
        
        UISegmentedControl *s = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
        [s insertSegmentWithTitle:@"English" atIndex:0 animated: YES];
        [s insertSegmentWithTitle:@"中文" atIndex:1 animated: YES];
        s.selectedSegmentIndex = 0;
        [s addTarget:self action:@selector(switchLanguageHandle:) forControlEvents: UIControlEventValueChanged];
        s.center = CGPointMake(100, 30);
        [_switchView addSubview:s];
    }
    
    return _switchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.switchView];
    [self loadingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CCExample *exam = self.examples[section];
    return exam.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCListCellID" forIndexPath:indexPath];
    
    CCExample *exam = self.examples[indexPath.section];
    cell.textLabel.text = exam.titles[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", exam.vcClass, exam.methods[indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CCExample *exam = self.examples[section];
    return exam.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCExample *exam = self.examples[indexPath.section];
    UIViewController *vc = [[exam.vcClass alloc] init];
    vc.title = exam.titles[indexPath.row];
    [vc setValue:exam.methods[indexPath.row] forKeyPath:@"method"];

    [self.navigationController pushViewController:vc animated:YES];
}


@end
