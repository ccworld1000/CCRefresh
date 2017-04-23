//
//  CCRefreshConst.m
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshConst.h"
#import <UIKit/UIKit.h>

const CGFloat CCRefreshLabelLeftInset = 25;
const CGFloat CCRefreshHeaderHeight = 54.0;
const CGFloat CCRefreshFooterHeight = 44.0;
const CGFloat CCRefreshFastAnimationDuration = 0.25;
const CGFloat CCRefreshSlowAnimationDuration = 0.4;

NSString *const CCRefreshKeyPathContentOffset = @"contentOffset";
NSString *const CCRefreshKeyPathContentInset = @"contentInset";
NSString *const CCRefreshKeyPathContentSize = @"contentSize";
NSString *const CCRefreshKeyPathPanState = @"state";

NSString *const CCRefreshHeaderLastUpdatedTimeKey = @"CCRefreshHeaderLastUpdatedTimeKey";

NSString *const CCRefreshHeaderIdleText = @"CCRefreshHeaderIdleText";
NSString *const CCRefreshHeaderPullingText = @"CCRefreshHeaderPullingText";
NSString *const CCRefreshHeaderRefreshingText = @"CCRefreshHeaderRefreshingText";

NSString *const CCRefreshAutoFooterIdleText = @"CCRefreshAutoFooterIdleText";
NSString *const CCRefreshAutoFooterRefreshingText = @"CCRefreshAutoFooterRefreshingText";
NSString *const CCRefreshAutoFooterNoMoreDataText = @"CCRefreshAutoFooterNoMoreDataText";

NSString *const CCRefreshBackFooterIdleText = @"CCRefreshBackFooterIdleText";
NSString *const CCRefreshBackFooterPullingText = @"CCRefreshBackFooterPullingText";
NSString *const CCRefreshBackFooterRefreshingText = @"CCRefreshBackFooterRefreshingText";
NSString *const CCRefreshBackFooterNoMoreDataText = @"CCRefreshBackFooterNoMoreDataText";

NSString *const CCRefreshHeaderLastTimeText = @"CCRefreshHeaderLastTimeText";
NSString *const CCRefreshHeaderDateTodayText = @"CCRefreshHeaderDateTodayText";
NSString *const CCRefreshHeaderNoneLastDateText = @"CCRefreshHeaderNoneLastDateText";

@implementation CCRefreshConst

@end
