//
//  UIScrollView+CCRefresh.h
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRefreshConst.h"

@class CCRefreshHeader, CCRefreshFooter;

@interface UIScrollView (CCRefresh)

/** 下拉刷新控件 */
@property (strong, nonatomic) CCRefreshHeader *CCHeader;
/** 上拉刷新控件 */
@property (strong, nonatomic) CCRefreshFooter *CCFooter;


#pragma mark - other
- (NSInteger)totalDataCount;
@property (copy, nonatomic) void (^CCReloadDataBlock)(NSInteger totalDataCount);

@end
