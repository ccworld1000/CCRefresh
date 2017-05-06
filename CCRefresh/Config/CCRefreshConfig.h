//
//  CCRefreshConfig.h
//  CCRefresh
//
//  Created by dengyouhua on 2017/5/6.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// Built in three languages
typedef NS_ENUM(NSInteger, CCRefreshConfigLanguageType) {
    CCRefreshConfigLanguageTypeEN,      //default en
    CCRefreshConfigLanguageTypeCNJT,    //中文繁体
    CCRefreshConfigLanguageTypeCNFT,    //中文简体
};

FOUNDATION_EXTERN CCRefreshConfigLanguageType  globalConfigLanguageType;

@interface CCRefreshConfig : NSObject

// selected Built in three languages | You should first configure
+ (void) selectedLanguage : (CCRefreshConfigLanguageType) languageType;

@end
