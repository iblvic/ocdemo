//
//  SwizzlesProblem.m
//  ocdemo
//
//  Created by haosimac on 2023/7/27.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface A : NSObject @end
@implementation A
- (void)dealloc{
    NSLog(@"A");
}
@end

@interface B : A @end
@implementation B @end
static void swizzleDeallocIfNeeded(Class classToSwizzle, dispatch_block_t block) {
    NSString *className = NSStringFromClass(classToSwizzle);
    SEL deallocSelector = sel_registerName("dealloc");

    Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
    void (*originalDealloc)(__unsafe_unretained id, SEL) = (__typeof__(originalDealloc))method_getImplementation(deallocMethod);

    id newDealloc = ^(__unsafe_unretained id self) {
        block();
        if (originalDealloc) {
            originalDealloc(self, deallocSelector);
        }
    };

    class_replaceMethod(classToSwizzle, deallocSelector, imp_implementationWithBlock(newDealloc), method_getTypeEncoding(deallocMethod));
}
static void swizzleDealloc(Class class, dispatch_block_t block) {
    SEL original = NSSelectorFromString(@"dealloc");
    Method method = class_getInstanceMethod(class, original);
    __block void (*originalIMP)(__unsafe_unretained id, SEL) = NULL;
    id newIMPBlock = ^(__unsafe_unretained id obj) {
        block();
        if (originalIMP) {
            originalIMP(obj, original);
        }else{
            struct objc_super superInfo = {obj,class_getSuperclass(class)};
            ((void(*)(void *, SEL))objc_msgSendSuper)(&superInfo, original);
        }
    };
    originalIMP = (void *)method_getImplementation(method);
    originalIMP = (void *)class_replaceMethod(class,
                                              original,
                                              imp_implementationWithBlock(newIMPBlock),
                                              method_getTypeEncoding(method));
}

void testSwizzles(void) {
    id b = [B new];
    swizzleDeallocIfNeeded([B class], ^{
        NSLog(@"RAC");
    });
    swizzleDealloc([A class], ^{
        NSLog(@"Swizzled");
    });
}
