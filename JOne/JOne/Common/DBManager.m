//
//  DBManager.m
//  JOne
//
//  Created by Johnny on 31/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "DBManager.h"
#import "JpConst.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

//Database
+ (DBManager*)getSharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

- (BOOL)createDB
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirPath = dirPaths[0];
    
    // Build the path to the database file
    dbPath = [[NSString alloc] initWithString: [docDirPath stringByAppendingPathComponent: DB_NAME]];
    BOOL isSuccess = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath: dbPath ] == NO)
    {
        const char *dbPathUTF8 = [dbPath UTF8String];
        if (sqlite3_open(dbPathUTF8, &database) == SQLITE_OK)
        {
            //id INTEGER primary key autoincrement, NULL, INTEGER, REAL, TEXT, BLOB.
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ text primary key, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", TABLE_BM_CONFIG, COLUMN_CONFIG_ID, COLUMN_CONFIG_CD, COLUMN_CONFIG_NAME, COLUMN_CONFIG_VALUE, COLUMN_DESCRIPTION, COLUMN_LANG, COLUMN_CREATE_DATE_TIME, COLUMN_MODIFY_TIMESTAMP, COLUMN_DATA_STATE];
//            sql = @"CREATE TABLE IF NOT EXISTS bm_config (config_id text primary key, config_cd TEXT, config_name TEXT, config_value TEXT, description TEXT, lang TEXT, create_date_time TEXT, modify_timestamp TEXT, data_state TEXT)";
            char *errMsg;
            if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) isSuccess = NO;
            
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ text primary key, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", TABLE_CM_ARTICLE, COLUMN_ARTICLE_ID, COLUMN_ARTICLE_CD, COLUMN_TITLE, COLUMN_SUMMARY, COLUMN_CONTENT, COLUMN_AUTHORE, COLUMN_IMAGE_URL, COLUMN_ORIGIN_URL, COLUMN_TAG, COLUMN_DISPLAY_NO, COLUMN_ROLE_IDS, COLUMN_OPERATOR_ID, COLUMN_OPERATOR_NAME, COLUMN_LANG, COLUMN_CREATE_DATE_TIME, COLUMN_MODIFY_TIMESTAMP, COLUMN_DATA_STATE];
//            sql = @"CREATE TABLE IF NOT EXISTS cm_article (article_id text primary key, article_cd TEXT, title TEXT, summary TEXT, content TEXT, author TEXT, image_url TEXT, origin_url TEXT, tag TEXT, display_no INTEGER, role_ids TEXT, operator_id TEXT, operator_name TEXT, lang TEXT, create_date_time TEXT, modify_timestamp TEXT, data_state TEXT)";
            if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) isSuccess = NO;
            
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ text primary key, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ TEXT, %@ TEXT, %@ TEXT, %@ TEXT, %@ INTEGER, %@ INTEGER, %@ TEXT)", TABLE_CM_PHOTO, COLUMN_PHOTO_ID, COLUMN_PHOTO_NAME, COLUMN_REF_ARTICLE_ID, COLUMN_TITLE, COLUMN_THUMB_URL, COLUMN_URL,COLUMN_ORIGIN_URL, COLUMN_REMARK, COLUMN_TAG, COLUMN_DISPLAY_NO, COLUMN_ROLE_IDS, COLUMN_OPERATOR_ID, COLUMN_OPERATOR_NAME, COLUMN_LANG, COLUMN_CREATE_DATE_TIME, COLUMN_MODIFY_TIMESTAMP, COLUMN_DATA_STATE];
//            sql = @"CREATE TABLE IF NOT EXISTS cm_photo (photo_id text primary key, photo_name TEXT, ref_article_id TEXT, title TEXT, thumb_url TEXT, url TEXT, origin_url TEXT, remark TEXT, tag TEXT, display_no INTEGER, role_ids TEXT, operator_id TEXT, operator_name TEXT, lang TEXT, create_date_time TEXT, modify_timestamp TEXT, data_state TEXT)";
            if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) isSuccess = NO;
            
            if (!isSuccess) NSLog(@"Failed to create table : %s", errMsg);
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}

- (BOOL)insertOneRecord:(NSString*)tableName columnValueDic:(NSMutableDictionary*)columnValueDic
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) == SQLITE_OK)
    {
        NSArray *columns = [columnValueDic allKeys];
        NSMutableArray *values = [NSMutableArray array];
        [columns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *value = [NSString stringWithFormat:@"'%@'" ,[columnValueDic objectForKey:obj] ];
            [values addObject:value];
        }];
        
        NSString *sql = [NSString stringWithFormat: @"INSERT INTO '%@' (%@) VALUES (%@)", tableName, [columns componentsJoinedByString:@","], [values componentsJoinedByString:@","]];
        NSLog(@"Insert record into table sql : %@",sql);
        
        const char *sqlUTF8 = [sql UTF8String];
        if (sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, nil) == SQLITE_OK)
        {
            int i=1;
            for ( NSString *column in columns) {
                NSString *value = [columnValueDic objectForKey:column];
                if ([column isEqual:COLUMN_CREATE_DATE_TIME] || [column isEqual:COLUMN_MODIFY_TIMESTAMP] || [column isEqual:COLUMN_DISPLAY_NO]) {
                    if ([value isKindOfClass:[NSNull class]]) {
                        value = @"0";
                    }
                    sqlite3_bind_int64(statement, i, [value longLongValue]);
                } else {
                    if ([value isKindOfClass:[NSNull class]]) {
                        value = @"";
                    }
                    sqlite3_bind_text(statement, i, [value UTF8String], -1, NULL);
                }
                
                i++;
            }
        }
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSLog(@"insertRecordIntoTable Error updating table with Error: %s", sqlite3_errmsg(database));
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
        return YES;
    } else {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
    }
    return NO;
}

- (void)updateOneRecord:(NSString*)tableName pkColumnName:(NSString*)aPkColumnName pkValue:(NSString*)aPkValue updateColumnName:(NSString*)aUpdateColumnName updateValue:(NSString*)aUpdateValue
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) != SQLITE_OK )
    {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@ = '%@' where %@ = '%@'", tableName, aUpdateColumnName, aUpdateValue, aPkColumnName, aPkValue];
        NSLog(@"Update One Record SQL= %@", sql);
        const char *sqlUTF8 = [sql UTF8String];
        
        sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Update one record successfully");
        } else {
            NSLog(@"Update one record failed");
        }

        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
}

- (void)deleteRecords:(NSString *)aTableName
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) != SQLITE_OK )
    {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ ", aTableName];
        const char *sqlUTF8 = [sql UTF8String];
        
        sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Delete one record successfully");
        } else {
            NSLog(@"Delete one record failed");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
}

- (void)deleteOneRecord:(NSString*)aTableName pkColumnName:(NSString*)aPkColumnName pkValue:(NSString*)aPkValue
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) != SQLITE_OK )
    {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", aTableName, aPkColumnName, aPkValue];
        const char *sqlUTF8 = [sql UTF8String];
        NSLog(@"deleteOneRecord %@", sql);
        
        sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Delete one record successfully");
        } else {
            NSLog(@"Delete one record failed");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
}

- (void)exeSql:(NSString*)aSql
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) != SQLITE_OK )
    {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
    }
    else
    {
        NSLog(@"SQL= %@", aSql);
        const char *sqlUTF8 = [aSql UTF8String];
        
        sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Successfully");
        } else {
            NSLog(@"Failed");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
}

- (NSMutableArray*)getCmConfigs
{
    const char *dbPathUTF8 = [dbPath UTF8String];
    if (sqlite3_open(dbPathUTF8, &database) != SQLITE_OK )
    {
        sqlite3_close(database);
        NSAssert1(0, @"DB failed to create with Error: %s", sqlite3_errmsg(database));
        return Nil;
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ ", TABLE_BM_CONFIG];
        const char *sqlUTF8 = [sql UTF8String];
        
        NSMutableArray *cmConfigs = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(database, sqlUTF8, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:COLUMN_CONFIG_ID];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:COLUMN_CONFIG_CD];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:COLUMN_CONFIG_NAME];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:COLUMN_CONFIG_VALUE];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:COLUMN_CREATE_DATE_TIME];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:COLUMN_MODIFY_TIMESTAMP];
                [dic setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:COLUMN_DATA_STATE];
                [cmConfigs addObject:dic];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
        if ([cmConfigs count] > 0) {
            return cmConfigs;
        } else {
            return Nil;
        }
    }
}


@end
