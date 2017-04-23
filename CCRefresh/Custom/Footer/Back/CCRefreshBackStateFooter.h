//
//  CCRefreshBackStateFooter.h
//  CCRefresh
//
//  Created by deng you hua on 4/18/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshBackFooter.h"

@interface CCRefreshBackStateFooter : CCRefreshBackFooter
/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(CCRefreshState)state;

/** 获取state状态下的title */
- (NSString *)titleForState:(CCRefreshState)state;
@end
