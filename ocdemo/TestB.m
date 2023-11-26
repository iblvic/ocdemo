//
//  TestBlock.m
//  ocdemo
//
//  Created by haosimac on 2023/11/16.
//

#import "TestB.h"
#import <UIKit/UIKit.h>

struct Block_descriptor_1 {
    uintptr_t reserved;
    uintptr_t size;
};

typedef void(*BlockInvokeFunction)(void *, ...);

struct Block_layout {
    void * __ptrauth_objc_isa_pointer isa;
    volatile int32_t flags; // contains ref count
    int32_t reserved;
    BlockInvokeFunction invoke;
    struct Block_descriptor_1 *descriptor;
    // imported variables
};

@implementation TestB

- (void)test {
    static int i = 1;
    void (^block1)(void) = ^{
        NSLog(@"I'm block。%d", i);
    };
    struct Block_layout *pblock = (__bridge struct Block_layout *)block1;
    block1();
    NSLog(@"block1:%@, size:%ld", [block1 class], pblock->descriptor->size);
    NSLog(@"i = %d", i);
//    int j = 2;
//    // arc下默认__strong修饰，因此默认会进行copy操作
//    void (^block2)(void) = [block1 copy];
//    NSLog(@"block1:%@", [block1 class]);
//    NSLog(@"block2:%@", [block2 class]);
}








//void (^globalBlock)(void) = ^{
//    NSLog(@"I'm global block");
//};
//
//- (void)test {
////    void (^block)(void) = ^{
////        NSLog(@"I'm block");
////    };
//    void *p = 0;
//    NSLog(@"{");
//    {
////         UIButton *b = [UIButton new];
////        __weak typeof(self) weakSelf = self;
//        int i = 3;
////        __weak __block UIButton*wb = b;
//        static UIButton *stb = nil;
//        stb = [UIButton new];
//        __unsafe_unretained __block void (^staticBlock)(void) = ^{
//            NSLog(@"I'm static block, %@, %d", stb, i);
//        };
//        dispatch_async(dispatch_get_main_queue(), ^{
//            staticBlock();
//        });
//        p = (__bridge void *)staticBlock;
//        NSLog(@"block1 class:%@", [staticBlock class]);
//        __block id weakSelf = self;
//        self.block = ^{
//            NSLog(@"%p", weakSelf);
//            weakSelf = nil;
//            NSLog(@"--->");
//        };
//    }
//    NSLog(@"}");
////    __unsafe_unretained void (^tmpBlock)(void) = (__bridge id)p;
////    NSLog(@"block2 class:%@", [tmpBlock class]);
//}

@end
