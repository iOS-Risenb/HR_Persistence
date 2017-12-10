

#import <Foundation/Foundation.h>

@interface HR_Plist : NSObject

/// read array data from plist path
+ (NSArray *)hr_arrayFormPlistPath:(NSString *)path;

/// read dictionary data from plist path
+ (NSDictionary *)hr_dictionaryFormPlistPath:(NSString *)path;


/// read array data from plist path (mainBundle)
+ (NSArray *)hr_arrayFormPlistName:(NSString *)name;

/// read dictionary data from plist path (mainBundle)
+ (NSDictionary *)hr_dictionaryFormPlistName:(NSString *)name;

@end
