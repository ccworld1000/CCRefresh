//
//  CCRefreshBackGifFooter.h
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshBackStateFooter.h"

@interface CCRefreshBackGifFooter : CCRefreshBackStateFooter
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(CCRefreshState)state;
- (void)setImages:(NSArray *)images forState:(CCRefreshState)state;
@end
