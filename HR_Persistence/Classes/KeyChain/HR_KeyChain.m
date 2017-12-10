
#import "HR_KeyChain.h"
#import <Security/Security.h>

@implementation HR_KeyChain

#pragma mark - Public Methods

/** 储存数据 */
+ (void)hr_setValue:(id)value forKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self keychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/** 读取数据 */
+ (id)hr_valueForKey:(NSString *)key {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self keychainQuery:key];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
        } @finally {
            
        }
    }
    if (keyData)
    CFRelease(keyData);
    return ret;
}

/** 清除数据 */
+ (void)hr_clearValueForKey:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self keychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

#pragma mark - Private Methods

+ (NSMutableDictionary *)keychainQuery:(NSString *)key {
    return [@{
             (id)kSecClass : (id)kSecClassGenericPassword,
             (id)kSecAttrService : key,
             (id)kSecAttrAccount : key,
             (id)kSecAttrAccessible : (id)kSecAttrAccessibleAfterFirstUnlock
             } mutableCopy];
}

@end
