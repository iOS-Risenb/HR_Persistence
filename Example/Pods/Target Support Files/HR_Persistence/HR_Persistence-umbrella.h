#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HR_Archive.h"
#import "HR_ArchiveModel.h"
#import "HR_DB.h"
#import "HR_DBModel.h"
#import "HR_KeyChain.h"
#import "HR_Plist.h"

FOUNDATION_EXPORT double HR_PersistenceVersionNumber;
FOUNDATION_EXPORT const unsigned char HR_PersistenceVersionString[];

