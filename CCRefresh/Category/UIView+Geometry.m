//
//  UIView+Geometry.m
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "UIView+Geometry.h"

@implementation UIView (Geometry)

- (void)setCCX:(CGFloat)CCX
{
    CGRect frame = self.frame;
    frame.origin.x = CCX;
    self.frame = frame;
}

- (CGFloat)CCX
{
    return self.frame.origin.x;
}

- (void)setCCY:(CGFloat)CCY
{
    CGRect frame = self.frame;
    frame.origin.y = CCY;
    self.frame = frame;
}

- (CGFloat)CCY
{
    return self.frame.origin.y;
}

- (void)setCCW:(CGFloat)CCW
{
    CGRect frame = self.frame;
    frame.size.width = CCW;
    self.frame = frame;
}

- (CGFloat)CCW
{
    return self.frame.size.width;
}

- (void)setCCH:(CGFloat)CCH
{
    CGRect frame = self.frame;
    frame.size.height = CCH;
    self.frame = frame;
}

- (CGFloat)CCH
{
    return self.frame.size.height;
}

- (void)setCCSize:(CGSize)CCSize
{
    CGRect frame = self.frame;
    frame.size = CCSize;
    self.frame = frame;
}

- (CGSize)CCSize
{
    return self.frame.size;
}

- (void)setCCOrigin:(CGPoint)CCOrigin
{
    CGRect frame = self.frame;
    frame.origin = CCOrigin;
    self.frame = frame;
}

- (CGPoint)CCOrigin
{
    return self.frame.origin;
}


@end
