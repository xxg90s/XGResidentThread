//
//  XGResidentThread.m
//  XGResidentThread
//
//  Created by xxg90s on 2022/4/15.
//

#import "XGResidentThread.h"

@interface XGResidentThread()

@property (nonatomic, strong) NSThread *innerThread;
//@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@end

@implementation XGResidentThread

static NSMutableDictionary *xg_threadDictionary;

+ (void)executeTask:(XGResidentThreadTask)task threadIdentity:(nonnull NSString *)threadIdentity {
    if (!task || !threadIdentity || threadIdentity.length == 0) {
        return;
    }
    if (!xg_threadDictionary) {
        xg_threadDictionary = [[NSMutableDictionary alloc] init];
    }
    
    XGResidentThread *specifyThread = [xg_threadDictionary valueForKey:threadIdentity];
    
    if (!specifyThread) {
        specifyThread = [[XGResidentThread alloc] init];
        [specifyThread __setInnerThreadName:threadIdentity];
        
        [xg_threadDictionary setValue:specifyThread forKey:threadIdentity];
    }

    [specifyThread executeTask:task];
}


- (instancetype)init {
    if (self = [super init]) {
//        _stopped = NO;
        
//        __weak typeof(self) weakSelf = self;
        _innerThread = [[NSThread alloc] initWithBlock:^{
//            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//            while (weakSelf && !weakSelf.isStopped) {
//                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            }
            
            CFRunLoopSourceContext context = {0};
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        [_innerThread start];
    }
    return self;
}

- (void)executeTask:(XGResidentThreadTask)task {
    if (!self.innerThread || !task) {
        return;
    }
    
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) {
        return;
    }
    
    // execute after all tasks are executed
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    [self stop];
}

#pragma mark - private methods
- (void)__setInnerThreadName:(NSString *)name {
    self.innerThread.name = name;
}
- (void)__stop {
//    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(XGResidentThreadTask)task {
    @autoreleasepool {
        task();
    }
}

@end
