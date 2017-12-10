

#import <Foundation/Foundation.h>

@interface HR_DBModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) BOOL sexMan;
@property (nonatomic, strong) NSDate *birth;
@property (nonatomic, strong) NSData *head;

@end
