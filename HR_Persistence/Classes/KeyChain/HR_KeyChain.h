

#import <Foundation/Foundation.h>

@interface HR_KeyChain : NSObject

/** 储存数据 */
+ (void)hr_setValue:(id)value forKey:(NSString *)key;

/** 读取数据 */
+ (id)hr_valueForKey:(NSString *)key;

/** 清除数据 */
+ (void)hr_clearValueForKey:(NSString *)key;

@end
