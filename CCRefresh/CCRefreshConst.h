//
//  CCRefreshConst.h
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "HSUtilities.h"

// 弱引用
#define CCWeakSelf __weak typeof(self) weakSelf = self;

// 过期提醒
#define CCRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define CCRefreshMsgSend(...)      ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define CCRefreshMsgTarget(target) (__bridge void *)(target)

// 文字颜色
#define CCRefreshLabelTextColor HSColorRGB(90, 90, 90)

// 字体大小
#define CCRefreshLabelFont [HSFont boldSystemFontOfSize:14]

// 常量
FOUNDATION_EXTERN const CGFloat CCRefreshLabelLeftInset;
FOUNDATION_EXTERN const CGFloat CCRefreshHeaderHeight;
FOUNDATION_EXTERN const CGFloat CCRefreshFooterHeight;
FOUNDATION_EXTERN const CGFloat CCRefreshFastAnimationDuration;
FOUNDATION_EXTERN const CGFloat CCRefreshSlowAnimationDuration;

FOUNDATION_EXTERN NSString *const CCRefreshKeyPathContentOffset;
FOUNDATION_EXTERN NSString *const CCRefreshKeyPathContentSize;
FOUNDATION_EXTERN NSString *const CCRefreshKeyPathContentInset;
FOUNDATION_EXTERN NSString *const CCRefreshKeyPathPanState;

FOUNDATION_EXTERN NSString *const CCRefreshHeaderLastUpdatedTimeKey;

FOUNDATION_EXTERN NSString *const CCRefreshHeaderIdleText;
FOUNDATION_EXTERN NSString *const CCRefreshHeaderPullingText;
FOUNDATION_EXTERN NSString *const CCRefreshHeaderRefreshingText;

FOUNDATION_EXTERN NSString *const CCRefreshAutoFooterIdleText;
FOUNDATION_EXTERN NSString *const CCRefreshAutoFooterRefreshingText;
FOUNDATION_EXTERN NSString *const CCRefreshAutoFooterNoMoreDataText;

FOUNDATION_EXTERN NSString *const CCRefreshBackFooterIdleText;
FOUNDATION_EXTERN NSString *const CCRefreshBackFooterPullingText;
FOUNDATION_EXTERN NSString *const CCRefreshBackFooterRefreshingText;
FOUNDATION_EXTERN NSString *const CCRefreshBackFooterNoMoreDataText;

FOUNDATION_EXTERN NSString *const CCRefreshHeaderLastTimeText;
FOUNDATION_EXTERN NSString *const CCRefreshHeaderDateTodayText;
FOUNDATION_EXTERN NSString *const CCRefreshHeaderNoneLastDateText;

// 状态检查
#define CCRefreshCheckState \
CCRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

@interface CCRefreshConst : NSObject

@end
