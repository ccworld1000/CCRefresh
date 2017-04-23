//
//  CCRefreshFooter.m
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshFooter.h"

@interface CCRefreshFooter()

@end

@implementation CCRefreshFooter
#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(CCRefreshCommomBlock)refreshingBlock
{
    CCRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    CCRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.CCH = CCRefreshFooterHeight;
    
    // 默认不会自动隐藏
    self.automaticallyHidden = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setCCReloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData
{
    self.state = CCRefreshStateNoMoreData;
}


- (void)resetNoMoreData
{
    self.state = CCRefreshStateIdle;
}
@end

