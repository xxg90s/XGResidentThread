//
//  ViewController.m
//  XGResidentThread
//
//  Created by xxg90s on 2022/4/15.
//

#import "ViewController.h"
#import "XGResidentThread.h"

@interface ViewController ()

@property (nonatomic, strong) XGResidentThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.thread = [[XGResidentThread alloc] init];
    
    [self.thread executeTask:^{
        NSLog(@"current resident thread operate = %@", [NSThread currentThread]);
    }];
    
    [XGResidentThread executeTask:^{
        NSLog(@"global resident thread operate = %@", [NSThread currentThread]);
    } threadIdentity:@"test"];
}


@end
