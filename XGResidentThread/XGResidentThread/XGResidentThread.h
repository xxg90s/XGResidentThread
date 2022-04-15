//
//  XGResidentThread.h
//  XGResidentThread
//
//  Created by xxg90s on 2022/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^XGResidentThreadTask)(void);

@interface XGResidentThread : NSObject

/// Execute operations in a global resident thread
/// @param task operations
/// @param threadIdentity global resident thread key
+ (void)executeTask:(XGResidentThreadTask)task threadIdentity:(NSString *)threadIdentity;

/// Execute task
- (void)executeTask:(XGResidentThreadTask)task;

/// Stop thread
- (void)stop;

@end

NS_ASSUME_NONNULL_END
