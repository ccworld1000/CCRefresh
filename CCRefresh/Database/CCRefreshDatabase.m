//
//  CCRefreshDatabase.m
//  CCRefresh
//
//  Created by deng you hua on 4/29/17.
//  Copyright © 2017 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCRefreshDatabase.h"
#import "NSBundle+CCRefresh.h"
#import "CCRefreshConfig.h"
#import <CCSQLite.h>

NSString *const CCRefreshLanguageKey = @"CCRefreshLanguage";

@interface CCRefreshDatabase ()

@property (strong, nonatomic) NSMutableDictionary *varsList;

+ (CCRefreshDatabase *) shareDatabase;

@end

@implementation CCRefreshDatabase

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.varsList = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    
    return self;
}


+ (CCRefreshDatabase *) shareDatabase {
    static CCRefreshDatabase *d;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        d = [CCRefreshDatabase new];
    });
    
    return d;
}

+ (void) loadingLanguage : (NSString *) language customDatabase : (NSString *) fullPath {
    NSString *lan = nil;
    NSString *path = nil;
    
    if (language) {
        lan = language;
    } else {
        lan = CCRefreshLanguageEN;
    }
    
    if (fullPath) {
        path = fullPath;
    } else {
        path = [NSBundle CCRefreshTranslate2DB];
    }
    
    __block NSMutableDictionary *list = [NSMutableDictionary dictionaryWithCapacity:0];
    __block CCResultSet *resultSet = nil;
    __block NSArray *keys = nil;
    __block NSUInteger count = 0;
    __block NSUInteger index = 0;
    
    NSString *sql = [NSString stringWithFormat:@"select * from '%@' where CCRefreshLanguage = '%@';", CCRefreshDatabaseDefaultTable, lan];
    CCSQLiteQueue *queue = [CCSQLiteQueue databaseQueueWithPath:path];
    [queue inDatabase:^(CCSQLite *db) {
        resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            keys = resultSet.columnNameToIndexMap.allKeys;
            count  = keys.count;
            for (index = 0; index < count; index++) {
                [list setObject:[resultSet objectForColumnName:keys[index]] forKey:keys[index]];
            }
        }
    }];
    
    if (list && list.count) {
        [[self shareDatabase].varsList removeAllObjects];
        [[self shareDatabase].varsList addEntriesFromDictionary: list];
    } else {
        NSLog(@"loading database error!");
    }
}

+ (void) loadingDefaultLanguage {
    [self loadingLanguage: nil customDatabase:nil];
}

+ (void) loadingDefaultCNFTLanguage {
    [self loadingLanguage:CCRefreshLanguageCNFT customDatabase: nil];
}

+ (void) loadingDefaultCNJTLanguage {
    [self loadingLanguage:CCRefreshLanguageCNJT customDatabase: nil];
}


+ (NSDictionary *) languageDictionary {
    if (![self shareDatabase].varsList || ([self shareDatabase].varsList.count == 0)) {
        if (globalConfigLanguageType == CCRefreshConfigLanguageTypeCNJT) {
            [self loadingDefaultCNJTLanguage];
        } else if (globalConfigLanguageType == CCRefreshConfigLanguageTypeCNFT) {
            [self loadingDefaultCNFTLanguage];
        } else {
            [self loadingDefaultLanguage];
        }
    }
    
    return [self shareDatabase].varsList;
}

@end
