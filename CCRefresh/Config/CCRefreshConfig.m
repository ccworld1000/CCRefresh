//
//  CCRefreshConfig.m
//  CCRefresh
//
//  Created by dengyouhua on 2017/5/6.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshConfig.h"

CCRefreshConfigLanguageType  globalConfigLanguageType = CCRefreshConfigLanguageTypeEN;

@implementation CCRefreshConfig

+ (void) selectedLanguage : (CCRefreshConfigLanguageType) languageType {
    if (languageType < CCRefreshConfigLanguageTypeEN || languageType > CCRefreshConfigLanguageTypeCNFT) {
        globalConfigLanguageType = CCRefreshConfigLanguageTypeEN;
    }
    
    globalConfigLanguageType = languageType;
}

@end
