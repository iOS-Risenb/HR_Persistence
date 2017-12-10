
#import "HR_ArchiveModel.h"
#import <objc/runtime.h>

@implementation HR_ArchiveModel

// code
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        // iver list
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            // decode
            id value = [decoder decodeObjectForKey:strName];
            // kvc
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}
// decode
- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        // kvc
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}


@end
