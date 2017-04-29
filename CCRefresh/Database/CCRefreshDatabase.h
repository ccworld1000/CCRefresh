//
//  CCRefreshDatabase.h
//  CCRefresh
//
//  Created by deng you hua on 4/29/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CCRefreshDatabaseDefaultName    @"CCRefreshTranslate2DB" //default database in CCRefresh.bundle, end in .db
#define CCRefreshDatabaseDefaultTable   @"CCRefreshTranslate2DB.table" //default table database

#pragma  mark CCRefreshLanguage
/**
 *  more detai, CCRefreshTranslate2DB https://github.com/ccworld1000/CCRefreshTranslate2DB
 *  if you want to custom, set CCRefreshLanguageCoustom : "CCRefreshLanguageCoustom"
 */

#define CCRefreshLanguageEN     @"en" //en default language
#define CCRefreshLanguageCNFT   @"中文繁体" //中文繁体
#define CCRefreshLanguageENJT   @"中文简体" //中文简体

#define CCRefreshLanguageCoustom   @"CCRefreshLanguageCoustom" //Coustom


@interface CCRefreshDatabase : NSObject

/**
 *  loadingDefaultLanguage | loading default
 */
+ (void) loadingDefaultLanguage;

/**
 *  loadingLanguage
 *
 *  @param language language description | default language set nil
 *  @param fullPath fullPath description | if you want to custom your database. use default set nil
 *  more detai, CCRefreshTranslate2DB https://github.com/ccworld1000/CCRefreshTranslate2DB
 *  if args are nil, Use loadingDefaultLanguage
 *  @return return value description
 */
+ (void) loadingLanguage : (NSString *) language customDatabase : (NSString *) fullPath;

/**
 *  languageDictionary | ensure your first loading database
 *
 *  @return return value description
 */
+ (NSDictionary *) languageDictionary;

@end
