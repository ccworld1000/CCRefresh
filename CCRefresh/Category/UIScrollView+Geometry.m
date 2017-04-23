//
//  UIScrollView+Geometry.m
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "UIScrollView+Geometry.h"

@implementation UIScrollView (Geometry)

- (void)setCCInsetT:(CGFloat)CCInsetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = CCInsetT;
    self.contentInset = inset;
}

- (CGFloat)CCInsetT
{
    return self.contentInset.top;
}

- (void)setCCInsetB:(CGFloat)CCInsetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = CCInsetB;
    self.contentInset = inset;
}

- (CGFloat)CCInsetB
{
    return self.contentInset.bottom;
}

- (void)setCCInsetL:(CGFloat)CCInsetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = CCInsetL;
    self.contentInset = inset;
}

- (CGFloat)CCInsetL
{
    return self.contentInset.left;
}

- (void)setCCInsetR:(CGFloat)CCInsetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = CCInsetR;
    self.contentInset = inset;
}

- (CGFloat)CCInsetR
{
    return self.contentInset.right;
}

- (void)setCCOffsetX:(CGFloat)CCOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = CCOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)CCOffsetX
{
    return self.contentOffset.x;
}

- (void)setCCOffsetY:(CGFloat)CCOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = CCOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)CCOffsetY
{
    return self.contentOffset.y;
}

- (void)setCCContentW:(CGFloat)CCContentW
{
    CGSize size = self.contentSize;
    size.width = CCContentW;
    self.contentSize = size;
}

- (CGFloat)CCContentW
{
    return self.contentSize.width;
}

- (void)setCCContentH:(CGFloat)CCContentH
{
    CGSize size = self.contentSize;
    size.height = CCContentH;
    self.contentSize = size;
}

- (CGFloat)CCContentH
{
    return self.contentSize.height;
}

@end
