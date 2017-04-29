//
//  NSBundle+CCRefresh.m
//  CCRefresh
//
//  Created by deng you hua on 4/17/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "NSBundle+CCRefresh.h"
#import "CCRefreshBase.h"
#import "CCRefreshDatabase.h"

@implementation NSBundle (CCRefresh)

+ (NSString *) CCRefreshTranslate2DB {
    return [[self CCRefreshBundle] pathForResource: CCRefreshDatabaseDefaultName ofType:@".db"];
}

+ (instancetype)CCRefreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[CCRefreshBase class]] pathForResource:@"CCRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)CCArrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self CCRefreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)CCLocalizedStringForKey:(NSString *)key {
    NSString *value = nil;
    if (!key || !([key isKindOfClass: [NSString class]])) {
        NSLog(@"ill args");
        return value;
    }
    
    NSDictionary *d = [CCRefreshDatabase languageDictionary];
    if (d && d.count) {
        value = d[[key lowercaseString]];
    }

    return value;
}


@end
