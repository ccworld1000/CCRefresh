//
//  CCRefreshAutoFooter.m
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshAutoFooter.h"

@interface CCRefreshAutoFooter()
@end

@implementation CCRefreshAutoFooter

#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        if (self.hidden == NO) {
            self.scrollView.CCInsetB += self.CCH;
        }
        
        // 设置位置
        self.CCY = _scrollView.CCContentH;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.CCInsetB -= self.CCH;
        }
    }
}


#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = YES;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.CCY = self.scrollView.CCContentH;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != CCRefreshStateIdle || !self.automaticallyRefresh || self.CCY == 0) return;
    
    if (_scrollView.CCInsetT + _scrollView.CCContentH > _scrollView.CCH) { // 内容超过一个屏幕
        // 这里的_scrollView.CCContentH替换掉self.CCY更为合理
        if (_scrollView.CCOffsetY >= _scrollView.CCContentH - _scrollView.CCH + self.CCH * self.triggerAutomaticallyRefreshPercent + _scrollView.CCInsetB - self.CCH) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != CCRefreshStateIdle) return;
    
    if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
        if (_scrollView.CCInsetT + _scrollView.CCContentH <= _scrollView.CCH) {  // 不够一个屏幕
            if (_scrollView.CCOffsetY >= - _scrollView.CCInsetT) { // 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if (_scrollView.CCOffsetY >= _scrollView.CCContentH + _scrollView.CCInsetB - _scrollView.CCH) {
                [self beginRefreshing];
            }
        }
    }
}

- (void)setState:(CCRefreshState)state
{
    CCRefreshCheckState
    
    if (state == CCRefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    } else if (state == CCRefreshStateNoMoreData || state == CCRefreshStateIdle) {
        if (CCRefreshStateRefreshing == oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
}

- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {
        self.state = CCRefreshStateIdle;
        
        self.scrollView.CCInsetB -= self.CCH;
    } else if (lastHidden && !hidden) {
        self.scrollView.CCInsetB += self.CCH;
        
        // 设置位置
        self.CCY = _scrollView.CCContentH;
    }
}
@end
