//
//  TestMemory.m
//  ocdemo
//
//  Created by haosimac on 2023/7/27.
//

#import "TestMemory.h"

@implementation TestMemory

+ (void)test {
    NSLog(@"123");
    @autoreleasepool {
        NSObject *obj = [NSObject new];
        CFTypeRef cfObj = CF_BridgingRetain(obj);
    }
    NSLog(@"456");
}

NS_INLINE CF_RETURNS_RETAINED CFTypeRef _Nullable CF_BridgingRetain(id _Nullable X) {
    return (__bridge_retained CFTypeRef)X;
}

NS_INLINE id _Nullable CF_BridgingRelease(CFTypeRef CF_CONSUMED _Nullable X) {
    return (__bridge_transfer id)X;
}


@end
