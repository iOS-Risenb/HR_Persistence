
#import "HR_Plist.h"

@implementation HR_Plist

/// read array data from plist path
+ (NSArray *)hr_arrayFormPlistPath:(NSString *)path {
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}
/// read dictionary data from plist path
+ (NSDictionary *)hr_dictionaryFormPlistPath:(NSString *)path {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    return dictionary;
}


/// read array data from plist path (mainBundle)
+ (NSArray *)hr_arrayFormPlistName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

/// read dictionary data from plist path (mainBundle)
+ (NSDictionary *)hr_dictionaryFormPlistName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return dictionary;
}

@end
