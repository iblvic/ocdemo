//
//  AppDelegate.m
//  ocdemo
//
//  Created by haosimac on 2023/3/6.
//

#import "AppDelegate.h"
#import "hookmsg.h"
#import "TaiChiKitManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TaiChiKitManager setupWithMode:TaiChiKitModeDefault];
    [TaiChiKitManager showKit];//启动展示太极
    startHandle();
    return YES;
}


#pragma mark - UISceneSession lifecycle


@end
