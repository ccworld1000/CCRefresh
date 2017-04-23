//
//  CCRefreshBase.h
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+CCRefresh.h"
#import "UIView+Geometry.h"
#import "CCRefreshConst.h"
#import "UIScrollView+Geometry.h"
#import "UIScrollView+CCRefresh.h"
#import "NSBundle+CCRefresh.h"

/**
 *  CCRefreshState
 */
typedef NS_ENUM(NSInteger, CCRefreshState) {
    /**
     *  Idle
     */
    CCRefreshStateIdle = 1,
    /**
     *  Pulling
     */
    CCRefreshStatePulling,
    /**
     *  Refreshing
     */
    CCRefreshStateRefreshing,
    /**
     *  WillRefresh
     */
    CCRefreshStateWillRefresh,
    /**
     *  NoMoreData
     */
    CCRefreshStateNoMoreData
};

/**
 *  CCRefreshCommomBlock | common block
 */
typedef void (^CCRefreshCommomBlock)();

/**
 *  CCRefreshBase | base class
 */
@interface CCRefreshBase : UIView
{
    UIEdgeInsets _scrollViewOriginalInset;
    
    /**
     *  super view
     */
    __weak UIScrollView *_scrollView;
}
#pragma mark - Refresh callback

@property (copy, nonatomic) CCRefreshCommomBlock refreshingBlock;

- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (weak, nonatomic) id refreshingTarget;

@property (assign, nonatomic) SEL refreshingAction;

- (void)executeRefreshingCallback;

#pragma mark - Refresh control

- (void)beginRefreshing;
- (void)beginRefreshingWithCompletionBlock:(CCRefreshCommomBlock)completionBlock;

@property (copy, nonatomic) CCRefreshCommomBlock beginRefreshingCompletionBlock;

@property (copy, nonatomic) CCRefreshCommomBlock endRefreshingCompletionBlock;

- (void)endRefreshing;
- (void)endRefreshingWithCompletionBlock:(CCRefreshCommomBlock)completionBlock;

- (BOOL)isRefreshing;

@property (assign, nonatomic) CCRefreshState state;

#pragma mark - Subclass access
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;
@property (weak, nonatomic, readonly) UIScrollView *scrollView;

#pragma mark - Subclass implementation
/** init */
- (void)prepare NS_REQUIRES_SUPER;
/** placeSubviews frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** scrollView contentOffset change */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** scrollView contentSize change */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
/** scrollView drag state change*/
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;


#pragma mark - other
@property (assign, nonatomic) CGFloat pullingPercent;
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;
@end
