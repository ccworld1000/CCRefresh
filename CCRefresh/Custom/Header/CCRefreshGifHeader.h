//
//  CCRefreshGifHeader.h
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshStateHeader.h"

@interface CCRefreshGifHeader : CCRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(CCRefreshState)state;
- (void)setImages:(NSArray *)images forState:(CCRefreshState)state;
@end
