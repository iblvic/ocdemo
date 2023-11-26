//
//  SunnyInterview.m
//  ocdemo
//
//  Created by haosimac on 2023/7/19.
//

#import "SunnyInterview.h"


@implementation Father
@end

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}
@end

@implementation NSObject (Sark)
- (void)foo {
    NSLog(@"IMP: -[NSObject (Sark) foo]");
}
+ (void)test {
    [NSObject foo];
    [[NSObject new] foo];
}
@end

@implementation Sark

- (void)speak {
    NSLog(@"my name's %@", self.name);
}

@end

void testEntry(void) {
    
    Son *s = [[Son alloc] init];
    BOOL rets1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL rets2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL rets3 = [(id)[Father class] isKindOfClass:[Father class]];
    BOOL rets4 = [(id)[Father class] isMemberOfClass:[Father class]];
    NSLog(@"%d,%d,%d,%d", rets1, rets2, rets3, rets4);
    [NSObject test];
    
    NSString *name = @"sark";
    id cls = [Sark class];
    void *obj = &cls;
    [(__bridge id)obj speak];
}
