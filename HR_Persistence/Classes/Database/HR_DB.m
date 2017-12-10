

#import "HR_DB.h"
#import "HR_DBModel.h"

@interface HR_DB ()

@end

// table
static NSString *t_xx = @"t_xx";
// column
static NSString *c_id = @"c_id";
static NSString *c_name = @"c_name";
static NSString *c_nick = @"c_nick";
static NSString *c_age = @"c_age";
static NSString *c_height = @"c_height";
static NSString *c_sexMan = @"c_sexMan";
static NSString *c_birth = @"c_birth";
static NSString *c_head = @"c_head";

@interface HR_DB ()

@property (nonatomic, copy) NSString *dbPath;

@end

@implementation HR_DB

@synthesize databaseQueue = _databaseQueue;
@synthesize db = _db;

#pragma mark - Singleton

+ (instancetype)HR_Share {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{\
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[self class] HR_Share];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [[self class] HR_Share];
}

#pragma mark - Init
- (instancetype)init {
    self = [super init];
    if (self) {
        //create table
        NSString *filePath = self.dbPath;
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
        NSLog(@"✅✅✅ DB PATH: <%@>",filePath);
    }
    return self;
}

#pragma mark - Table Level
/** create table */
- (void)HR_TableCreate:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure {
    /*
     INTEGER -> NSInteger/int
     TEXT -> NSString
     FLOAT -> float
     DOUBLE -> double
     BOOLEAN -> BOOL
     DATE -> NSDate
     BLOB -> NSData
     
     PRIMARY KEY 主键
     UNIQUE 唯一
     NOT NULL 非空
     */
    NSString *sql_createTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (\
                                 %@ INTEGER PRIMARY KEY,\
                                 %@ TEXT(32),\
                                 %@ TEXT(64),\
                                 %@ INTEGER(1) NOT NULL,\
                                 %@ FLOAT,\
                                 %@ BOOLEAN NOT NULL DEFAULT TRUE,\
                                 %@ DATE,\
                                 %@ BLOB\
                                 )", t_xx,
                                 c_id,
                                 c_name,
                                 c_nick,
                                 c_age,
                                 c_height,
                                 c_sexMan,
                                 c_birth,
                                 c_head];
    
    BOOL res = [self.db executeUpdate:sql_createTable];
    if (res) {
        NSLog(@"✅✅✅ create table success");
        if (success) {
            success();
        }
    } else {
        NSLog(@"❌❌❌ create table failure");
        if (failure) {
            failure();
        }
    }
}

/** drop table */
- (void)HR_TableDrop:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure {
    NSString *sql_dropTable = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if ([self.db executeUpdate:sql_dropTable]) {
        NSLog(@"✅✅✅ drop table success");
        if (success) {
            success();
        }
    } else {
        NSLog(@"❌❌❌ drop table failure");
        if (failure) {
            failure();
        }
    }
}

#pragma mark - Data Level

// update operation (common)
- (void)HR_Update:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure {
    BOOL result = [self.db executeUpdate:sql];
    if (result) {
        if (success) {
            success();
        }
    } else {
        if (failure) {
            failure();
        }
    }
}
// query operation (common)
- (void)HR_Query:(NSString *)sql result:(void(^)(NSArray *))result {
    FMResultSet *resultSet = [self.db executeQuery:sql];
    NSMutableArray *tempMarr = [NSMutableArray array];
    while ([resultSet next]) {
        HR_DBModel *model = [[HR_DBModel alloc] init];
        model.name = [resultSet stringForColumn:c_name];
        model.nick = [resultSet stringForColumn:c_nick];
        model.age = [resultSet intForColumn:c_age];
        model.height = [resultSet doubleForColumn:c_height];
        model.sexMan = [resultSet boolForColumn:c_sexMan];
        model.birth = [resultSet dateForColumn:c_birth];
        model.head = [resultSet dataForColumn:c_head];
        [tempMarr addObject:model];
    }
    if (result) {
        result(tempMarr);
    }
}

/** insert data */
- (void)HR_DataInsert:(HR_DBModel *)model intoTable:(NSString *)tableName success:(void(^)(void))success failure:(void(^)(void))failure {
    
    NSString *sql_dataInsert = [NSString stringWithFormat:@"INSERT INTO %@ (\
                                  %@,\
                                  %@,\
                                  %@,\
                                  %@,\
                                  %@,\
                                  %@,\
                                  %@\
                                  ) values (?, ?, ?, ?, ?, ?, ?)", t_xx,
                                c_name,
                                c_nick,
                                c_age,
                                c_height,
                                c_sexMan,
                                c_birth,
                                c_head];
    
    BOOL result = [self.db executeUpdate:sql_dataInsert,
                model.name,
                model.nick,
                @(model.age),
                @(model.height),
                @(model.sexMan),
                model.birth,
                model.head];
    if (result) {
        NSLog(@"✅✅✅ insert data success");
        if (success) {
            success();
        }
    } else {
        NSLog(@"❌❌❌ insert data failure");
        if (failure) {
            failure();
        }
    }
}

/** delete data */
- (void)HR_DataDelete:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure {
    BOOL result = [self.db executeUpdate:sql];
    if (result) {
        NSLog(@"✅✅✅ delete datas success");
        if (success) {
            success();
        }
    } else {
        NSLog(@"❌❌❌ delete datas failure");
        if (failure) {
            failure();
        }
    }
}

/** update data */
- (void)HR_DataUpdate:(NSString *)sql success:(void(^)(void))success failure:(void(^)(void))failure {
    BOOL res = [self.db executeUpdate:sql];
    if (res) {
        NSLog(@"✅✅✅ Update Datas Success");
        if (success) {
            success();
        }
    } else {
        NSLog(@"❌❌❌ Update Datas Failure");
        if (failure) {
            failure();
        }
    }
}
/** select data */
- (void)HR_SelectSql:(NSString *)sql result:(void(^)(NSArray <HR_DBModel *>*datas))result {
    FMResultSet *res = [self.db executeQuery:sql];
    NSMutableArray *marray = [NSMutableArray array];
    while ([res next]) {
        HR_DBModel *model = [[HR_DBModel alloc] init];
        model.name = [res stringForColumn:@"name"];
        model.nick = [res stringForColumn:@"nick"];
        model.age = [res intForColumn:@"age"];
        model.height = [res doubleForColumn:@"height"];
        model.sexMan = [res boolForColumn:@"sexMan"];
        model.birth = [res dateForColumn:@"birth"];
        model.head = [res dataForColumn:@"head"];
        [marray addObject:model];
    }
    if (result) {
        result(marray);
    }
}

#pragma mark - Multitask

- (void)HR_Tasks:(void(^)(HR_DB *manager))handle {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.db open];
        if (handle) {
            handle(self);
        }
        [self.db close];
    });
}

#pragma mark - Lazy Loading

- (NSString *)dbPath {
    if (!_dbPath) {
        _dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject stringByAppendingPathComponent:@"HR_DB.db"];
    }
    return _dbPath;
}

- (FMDatabase *)db {
    if (!_db) {
        _db = [FMDatabase databaseWithPath:self.dbPath];
    }
    return _db;
}

@end
