//
//  CCRefreshBase.m
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshBase.h"
#import "CCRefreshConst.h"

@interface CCRefreshBase()
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@end

@implementation CCRefreshBase

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // prepare
        [self prepare];
        
        // default CCRefreshStateIdle
        self.state = CCRefreshStateIdle;
    }
    return self;
}

- (void)prepare
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [HSColor clearColor];
}

- (void)layoutSubviews
{
    [self placeSubviews];
    
    [super layoutSubviews];
}

- (void)placeSubviews{}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];

    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    [self removeObservers];
    
    if (newSuperview) {
        self.CCW = newSuperview.CCW;
        self.CCX = 0;

        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceVertical = YES;
        _scrollViewOriginalInset = _scrollView.contentInset;

        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.state == CCRefreshStateWillRefresh) {
        self.state = CCRefreshStateRefreshing;
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:CCRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:CCRefreshKeyPathContentSize options:options context:nil];
    self.pan = self.scrollView.panGestureRecognizer;
    [self.pan addObserver:self forKeyPath:CCRefreshKeyPathPanState options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:CCRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:CCRefreshKeyPathContentSize];;
    [self.pan removeObserver:self forKeyPath:CCRefreshKeyPathPanState];
    self.pan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.userInteractionEnabled) return;
    
    if ([keyPath isEqualToString:CCRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }

    if (self.hidden) return;
    if ([keyPath isEqualToString:CCRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:CCRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{}

#pragma mark - public
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    self.refreshingTarget = target;
    self.refreshingAction = action;
}

- (void)setState:(CCRefreshState)state
{
    _state = state;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

#pragma mark Enter Refreshing status
- (void)beginRefreshing
{
    [UIView animateWithDuration:CCRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;

    if (self.window) {
        self.state = CCRefreshStateRefreshing;
    } else {
        if (self.state != CCRefreshStateRefreshing) {
            self.state = CCRefreshStateWillRefresh;
            [self setNeedsDisplay];
        }
    }
}

- (void)beginRefreshingWithCompletionBlock:(CCRefreshCommomBlock)completionBlock
{
    self.beginRefreshingCompletionBlock = completionBlock;
    
    [self beginRefreshing];
}

#pragma mark endRefreshing
- (void)endRefreshing
{
    self.state = CCRefreshStateIdle;
}

- (void)endRefreshingWithCompletionBlock:(CCRefreshCommomBlock)completionBlock
{
    self.endRefreshingCompletionBlock = completionBlock;
    
    [self endRefreshing];
}

#pragma mark isRefreshing
- (BOOL)isRefreshing
{
    return self.state == CCRefreshStateRefreshing || self.state == CCRefreshStateWillRefresh;
}

#pragma mark automaticallyChangeAlpha
- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha
{
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if (self.isRefreshing) return;
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    } else {
        self.alpha = 1.0;
    }
}

#pragma mark alpha = pullingPercent
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) return;
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

#pragma mark - executeRefreshingCallback
- (void)executeRefreshingCallback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            CCRefreshMsgSend(CCRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
        if (self.beginRefreshingCompletionBlock) {
            self.beginRefreshingCompletionBlock();
        }
    });
}
@end

