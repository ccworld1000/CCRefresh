//
//  UIScrollView+CCRefresh.m
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "UIScrollView+CCRefresh.h"
#import "CCRefreshHeader.h"
#import "CCRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (CCRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (CCRefresh)

#pragma mark - header
static const char CCRefreshHeaderKey = '\0';
- (void)setCCHeader:(CCRefreshHeader *)CCHeader
{
    if (CCHeader != self.CCHeader) {
        // 删除旧的，添加新的
        [self.CCHeader removeFromSuperview];
        [self insertSubview:CCHeader atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"CCHeader"]; // KVO
        objc_setAssociatedObject(self, &CCRefreshHeaderKey,
                                 CCHeader, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"CCHeader"]; // KVO
    }
}

- (CCRefreshHeader *)CCHeader
{
    return objc_getAssociatedObject(self, &CCRefreshHeaderKey);
}

#pragma mark - footer
static const char CCRefreshFooterKey = '\0';
- (void)setCCFooter:(CCRefreshFooter *)CCFooter
{
    if (CCFooter != self.CCFooter) {
        // 删除旧的，添加新的
        [self.CCFooter removeFromSuperview];
        [self insertSubview:CCFooter atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"CCFooter"]; // KVO
        objc_setAssociatedObject(self, &CCRefreshFooterKey,
                                 CCFooter, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"CCFooter"]; // KVO
    }
}

- (CCRefreshFooter *)CCFooter
{
    return objc_getAssociatedObject(self, &CCRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(CCRefreshFooter *)footer
{
    self.CCFooter = footer;
}

- (CCRefreshFooter *)footer
{
    return self.CCFooter;
}

- (void)setHeader:(CCRefreshHeader *)header
{
    self.CCHeader = header;
}

- (CCRefreshHeader *)header
{
    return self.CCHeader;
}

#pragma mark - other
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MJRefreshReloadDataBlockKey = '\0';
- (void)setCCReloadDataBlock:(void (^)(NSInteger))CCReloadDataBlock
{
    [self willChangeValueForKey:@"CCReloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &MJRefreshReloadDataBlockKey, CCReloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"CCReloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))CCReloadDataBlock
{
    return objc_getAssociatedObject(self, &MJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.CCReloadDataBlock ? : self.CCReloadDataBlock(self.totalDataCount);
}
@end

@implementation UITableView (CCRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(cc_reloadData)];
}

- (void)cc_reloadData
{
    [self cc_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (CCRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(cc_reloadData)];
}

- (void)cc_reloadData
{
    [self cc_reloadData];
    
    [self executeReloadDataBlock];
}
@end
