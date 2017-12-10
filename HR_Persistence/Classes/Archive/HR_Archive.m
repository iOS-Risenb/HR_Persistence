

#import "HR_Archive.h"

@implementation HR_Archive

+ (void)HR_Code:(id)value forKay:(NSString *)key toPath:(NSString *)path {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:value forKey:key];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
}

+ (id)HR_DecodeForKey:(NSString *)key fromPath:(NSString *)path {
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id archiveData = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return archiveData;
}

@end
