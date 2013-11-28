//
//  DBManager.h
//  JOne
//
//  Created by Johnny on 31/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *dbPath;
}

+ (DBManager*)getSharedInstance;
- (BOOL)createDB;
- (BOOL)insertOneRecord:(NSString*)tableName columnValueDic:(NSMutableDictionary*)columnValueDic;

- (void)updateOneRecord:(NSString*)tableName pkColumnName:(NSString*)aPkColumnName pkValue:(NSString*)aPkValue updateColumnName:(NSString*)aUpdateColumnName updateValue:(NSString*)aUpdateValue;

- (void)deleteRecords:(NSString *)aTableName;
- (void)deleteOneRecord:(NSString*)aTableName pkColumnName:(NSString*)aPkColumnName pkValue:(NSString*)aPkValue;

- (void)exeSql:(NSString*)aSql;

- (NSMutableArray*)getCmConfigs;

@end
