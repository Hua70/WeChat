//
//  ViewController.m
//  WeChat
//
//  Created by YWH on 15/9/16.
//  Copyright (c) 2015年 YWH. All rights reserved.
//

#import "ViewController.h"
#include <objc/runtime.h>
#import "LSApplicationProxy.h"
#import <dlfcn.h>
//#import "LSApplicationWorkspace.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self installedAppList];
}
- (IBAction)jumpToFriendCircle:(id)sender {   //com.tencent.xin  微信包名
    
    NSString *weChatIdentifier = @"com.tencent.xin";
    if (CURRENT_SYSTEM_VERSION < 7) {
        void* sbServices = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
        int (*SBSLaunchApplicationWithIdentifier)(CFStringRef identifier, Boolean suspended) = dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");
        const char *strBundleId = [weChatIdentifier cStringUsingEncoding:NSUTF8StringEncoding];
        int result = SBSLaunchApplicationWithIdentifier((__bridge CFStringRef)weChatIdentifier, NO);
        dlclose(sbServices);
    }else
    {
         Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
        [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:weChatIdentifier];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)installedAppList{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//   NSArray *allApp = [workspace performSelector:@selector(allApplications)];
//#pragma clang diagnostic pop
//#pragma clang diagnostic pop
//     for (LSApplicationProxy *item in allApp) {
//         NSString *identifier = [item applicationIdentifier];
//         NSString *localizedName = [item localizedName];
//         NSLog(@"%@:%@",localizedName,identifier);
//     }
//}


@end
