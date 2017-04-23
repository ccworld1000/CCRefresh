//
//  UIScrollView+Geometry.h
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Geometry)

@property (assign, nonatomic) CGFloat CCInsetT;
@property (assign, nonatomic) CGFloat CCInsetB;
@property (assign, nonatomic) CGFloat CCInsetL;
@property (assign, nonatomic) CGFloat CCInsetR;

@property (assign, nonatomic) CGFloat CCOffsetX;
@property (assign, nonatomic) CGFloat CCOffsetY;

@property (assign, nonatomic) CGFloat CCContentW;
@property (assign, nonatomic) CGFloat CCContentH;

@end
