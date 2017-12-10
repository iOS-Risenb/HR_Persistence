
/*
 注：被解归档的自定义对象类型要继承于 HR_ArchiveBaseModel 类
 */

#import <Foundation/Foundation.h>

@interface HR_Archive : NSObject

// code (key:归档多文件的区分 path:文件的绝路径，含文件名称)
+ (void)HR_Code:(id)value forKay:(NSString *)key toPath:(NSString *)path;

// decode (key:解档多文件的区分 path:文件的绝路径，含文件名称)
+ (id)HR_DecodeForKey:(NSString *)key fromPath:(NSString *)path;

@end
