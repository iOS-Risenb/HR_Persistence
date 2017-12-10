
#import <Foundation/Foundation.h>
#import "FMDB/FMDB.h"

@class HR_DBModel;

@interface HR_DB : NSObject

@property (nonatomic, strong, readonly) FMDatabase *db;
@property (nonatomic, strong, readonly) FMDatabaseQueue *databaseQueue;

#pragma mark - Init
/** init(singleton) */
+ (instancetype)HR_Share;

#pragma mark - Table Level
/** create table */
- (void)HR_TableCreate:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure;
/** drop table */
- (void)HR_TableDrop:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure;

#pragma mark - Data Level

// update operation (common)
- (void)HR_Update:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure;
// query operation (common)
- (void)HR_Query:(NSString *)sql result:(void(^)(NSArray *))result;

/** insert data */
- (void)HR_DataInsert:(HR_DBModel *)model intoTable:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure;
/** delete data */
- (void)HR_DataDelete:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure;
/** update data */
- (void)HR_DataUpdate:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure;
/** select data */
- (void)HR_SelectSql:(NSString *)sql result:(void(^)(NSArray <HR_DBModel *>*datas))result;

#pragma mark - Multitask
- (void)HR_Tasks:(void(^)(HR_DB *manager))handle;

@end
