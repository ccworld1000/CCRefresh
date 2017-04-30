//
//  UIViewController+Method.m
//  CCRefreshiOS
//
//  Created by deng you hua on 4/30/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "UIViewController+Method.h"
#import <objc/runtime.h>

static CCMethodKey;

@implementation UIViewController (Method)

- (void) setMethod : (NSString *) method {
    if (!method || ![method isKindOfClass:[NSString class]]) {
        NSLog(@"error arg");
        return;
    }
    
    objc_setAssociatedObject(self, &CCMethodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *) method {
    return objc_getAssociatedObject(self, &CCMethodKey);
}

@end
