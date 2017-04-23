//
//  CCRefreshBackStateFooter.m
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshBackStateFooter.h"

@interface CCRefreshBackStateFooter()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation CCRefreshBackStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel CCLabel]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(CCRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(CCRefreshState)state {
    return self.stateTitles[@(state)];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = CCRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle CCLocalizedStringForKey:CCRefreshBackFooterIdleText] forState:CCRefreshStateIdle];
    [self setTitle:[NSBundle CCLocalizedStringForKey:CCRefreshBackFooterPullingText] forState:CCRefreshStatePulling];
    [self setTitle:[NSBundle CCLocalizedStringForKey:CCRefreshBackFooterRefreshingText] forState:CCRefreshStateRefreshing];
    [self setTitle:[NSBundle CCLocalizedStringForKey:CCRefreshBackFooterNoMoreDataText] forState:CCRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(CCRefreshState)state
{
    CCRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}
@end

