//
//  main.m
//  ocdemo
//
//  Created by haosimac on 2023/3/6.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Teacher.hpp"
#import <mach-o/dyld_images.h>
#import <mach-o/dyld.h>
#import <iostream>
#import "SwizzlesProblem.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import <objc/message.h>
//@import Darwin.malloc;

typedef NS_ENUM(NSInteger, InputType) {
    InputType1 = 1,
    InputType2 = 3,
    InputType3 = 4,
    InputType4 = 6,
    InputType5 = 90,
};

NSInteger test(InputType input) {
    switch (input) {
        case InputType1: return input + 1;
        case InputType2: return input + 3;
        case InputType3: return input + 4;
        case InputType4: return input + 6;
        case InputType5: return input + 9;
        default: return input;
    }
//    if (input == 1) {
//        return input + 1;
//    } else if (input == 2) {
//        return input + 2;
//    } else {
//        return input + 3;
//    }
}

int testWhile(void) {
    int32_t i = 0;
    while (i < 5) {
        printf("i=%d", i);
        i++;
    }
    return i;
}

int testFor(void) {
    for (NSInteger i = 0; i < 5; i++) {
        printf("i=%ld", i);
    }
    return 0;
}

int testDoWhile(void) {
    int32_t i = 0;
    do {
        printf("i=%d", i);
        i++;
    } while (i < 5);
    return i;
}

void testOC(void) {
    NSObject *obj = [[NSObject alloc] init];
//    NSLog(@"size:%ld", malloc_size((void *)CFBridgingRetain(obj)));
}


class User {
public:
    int id;
    User(int id) {
        this->id = id;
    }
    User(User &other) {
        this->id = other.id;
    }
    ~User() {
        std::cout << "析构函数" << std::endl;
    }
};
User GetUser() {
    User user(1);
    return user;
}

//struct Args
//{
//    void*  mainExecutable;
//    uintptr_t             argc;
//#define MAX_KERNEL_ARGS   128
//    const char*           args[MAX_KERNEL_ARGS]; // argv[], then envp[], then apple[]
//
//    const char** findArgv() const
//    {
//        return (const char**)&args[0];
//    }
//
//    const char** findEnvp() const
//    {
//        // argv array has nullptr at end, so envp starts at argc+1
//        return (const char**)&args[argc + 1];
//    }
//
//    const char** findApple() const
//    {
//        // envp array has nullptr at end, apple starts after that
//        const char** p = findEnvp();
//        while ( *p != nullptr )
//            ++p;
//        ++p;
//        return p;
//    }
//};
//extern struct dyld_all_image_infos* gProcessInfo;

int funcA() {
    int i = 1 + 1;
    return i;
}
int funcB() {
    int j = 1;
    j = j + funcA();
    return j;
}
typedef struct {
    int a; int b; int c; int d; int e; int f; int g; int h; int i; int j; int k;
} NUM;

NUM funcC(int a, int b, int c, int d , int e, int f, int g, int h, int i, int j, int k) {
    NUM n = {};
    n.a = a;
    n.b = b;
    n.c = c;
    n.d = d;
    n.e = e;
    n.f = f;
    n.g = g;
    n.h = h;
    n.i = i;
    n.j = j;
    n.k = k;
    //int ret = a+b+c+d+e+f+g+h+i+j+k;
    return n;
}

@implementation NSString(MD5Addition)

- (NSString *) stringToMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString ;
}

@end



typedef struct __PersonData {
    int a; int b; int c; int d;
} PersonData;

void mylog(int a, int b, int c, int d) {
    
    NSLog(@"a:%d, b:%d, c:%d, d:%d", a, b, c, d);
}

//- (PersonData)data {
//    PersonData d = {};
//    d.a = 1;
//    d.b = 2;
//    d.c = 3;
//    d.d = 4;
//    return d;
//}


@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation Person
@end

@interface Person(LHAdd)

@end

@implementation Person(LHAdd)

- (void)printDescription {
    NSLog(@"%@-%ld", self.name, self.age);
}

@end

// 实例方法
static NSString* schoolIMP(id self, SEL sel) {
    Ivar schoolIvar = class_getInstanceVariable(object_getClass(self), "school");
    id schoolName = object_getIvar(self, schoolIvar);
    if (!schoolName) {
        schoolName = @"hk university";
        object_setIvar(self, schoolIvar, schoolName);
        NSLog(@"set school name");
    }
    return schoolName;
}
// 类方法
static NSString* classRoomIMP(id self, SEL sel) {
    return @"No.1";
}

typedef struct __Base {
    uint8_t a;
    uint8_t b;
} Base;

typedef struct __String {
    Base base;
    union {
        struct __inline1 {
            uint8_t length;
        } inline1;
        struct __inline2 {
            uint8_t buffer;
            uint8_t length;
            uint8_t deallocator;
        } inline2;
        struct __inline3 {
            uint8_t buffer;
            uint8_t deallocator;
        } inline3;
    } variants;
} String;

//int main(int argc, char ** argv) {
//    String s = {0};
//    NSLog(@"sizeof(String) = %ld", sizeof(String));
//    NSLog(@"&s = %p", &s);
//    NSLog(@"&(s.base) = %p", &(s.base));
//    NSLog(@"&(s.variants) = %p", &(s.variants));
//    NSLog(@"&(s.variants.inline1.length) = %p", &(s.variants.inline1.length));
//    NSLog(@"&(s.variants.inline2.buffer) = %p", &(s.variants.inline2.buffer));
//    NSLog(@"&(s.variants.inline3.deallocator) = %p", &(s.variants.inline3.deallocator));
//    return 0;
//}

@interface ZAStringScanner : NSObject

@end

@implementation ZAStringScanner
// 提取#号之间的字符串范围
// 输入：text = @"tttttttt#mmmmm#tttt"
// 输出：*resultText = @"ttttttttmmmmmtttt"; *markRanges = @[(8,5)]
+(void)scanText:(NSString *)text resultText:(NSString **)resultText markRanges:(NSArray<NSValue *> **)markRanges {
    if ([text rangeOfString:@"#"].length == 0) {
        *resultText = text;
        return;
    }
    NSMutableString *tmpResultText = [NSMutableString string];
    NSMutableArray *tmpMarkRanges = @[].mutableCopy;
    NSInteger left = -1, tmpLeft = -1, right = -1;
    for (NSInteger i = 0; i < text.length; i++) {
        NSString *str = [text substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@"#"]) {
            [tmpResultText appendString:str];
        } else if (left == -1) {
            left = i;
            tmpLeft = tmpResultText.length;
        } else if (right == -1) {
            right = i;
            // right-left-1为#号之间的字符串长度。
            NSInteger markLen = right-left-1;
            if (markLen != 0) {
                NSRange mark = NSMakeRange(tmpLeft, markLen);
                [tmpMarkRanges addObject:[NSValue valueWithRange:mark]];
            }
            left = -1;
            right = -1;
        }
    }
    *resultText = tmpResultText.copy;
    *markRanges = tmpMarkRanges.copy;
}

+ (void)testWithString:(NSString *)string markStrings:(NSArray *)markStrings {
    NSString *replacedString1 = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSMutableArray<NSValue *> *markRanges1 = @[].mutableCopy;
    for (NSString *ms in markStrings) {
        NSRange r = [replacedString1 rangeOfString:ms];
        if (r.length > 0) {
            [markRanges1 addObject:[NSValue valueWithRange:r]];
        }
    }
    NSString *replacedString2 = nil;
    NSArray<NSValue *> *markRanges2 = nil;
    [self scanText:string resultText:&replacedString2 markRanges:&markRanges2];
    NSLog(@"replacedString2:%@",replacedString2);
    NSLog(@"markRanges2:%@",markRanges2);
    NSAssert([replacedString1 isEqualToString:replacedString2], @"replacedString错误");
    for (NSInteger i = 0; i < markRanges1.count; i++) {
        NSAssert([markRanges1[i] isEqualToValue:markRanges2[i]], @"markRanges错误");
    }
}

@end

int main(int argc, char ** argv) {
//    // 内部会创建类和元类，并设置好isa的指针以及class_rw_t, class_ro_t结构体的值(包括初步设置instanceStart，instanceSize)。
//    // extraBytes指定额外的字节数。总字节数 = sizeof(objc_class) + extraBytes
//    Class student = objc_allocateClassPair(objc_getClass("Person"), "Student", 0); // objc_getClass("Person");
//    Class studentMetaClass = object_getClass((id)student);
//    NSLog(@"meta class:%@, %p <-- %p", studentMetaClass, studentMetaClass, student);
//    Class personMetaClass = object_getClass((id)objc_getClass("Person"));
//    if (class_getSuperclass(studentMetaClass) == personMetaClass) {
//        NSLog(@"Student的元类是Person元类的子类");
//    }
//    // 添加实例变量，注意不能给类添加变量，即这里不能传元类
//    // 并且这个类是allocated but not yet registered
//    // malloc并复制一份class_ro_t以及复制一份ivar_list_t，以使能够更改里面的数据。创建一个ivar设置好offset,name,type,size。
//    // 最后设置实例变量的大小，cls->setInstanceSize((uint32_t)(offset + size));
//    class_addIvar(student, "school", 8, 8, @encode(NSString *));
//    // 添加实例方法
//    class_addMethod(student, sel_registerName("school"), (IMP)schoolIMP, "@@:");
//    class_addMethod(studentMetaClass, sel_registerName("classRoom"), (IMP)classRoomIMP, "@@:");
//    objc_registerClassPair(student);
//    id s = [[student alloc] init];
//    //访问类方法
//    NSLog(@"class room: %@", ((NSString *(*)(id,SEL))objc_msgSend)(student, sel_registerName("classRoom")));
//    for (NSInteger i = 0; i < 3; i++) {
//        // 访问实例方法
//        NSString *schoolName = ((NSString *(*)(id,SEL))objc_msgSend)(s, sel_registerName("school"));
//        NSLog(@"%@", schoolName);
//    }
//    [(Person *)s printDescription];
//    // 访问Person属性
//    ((void (*)(id,SEL,NSString*))objc_msgSend)(s, sel_registerName("setName:"), @"小明");
//    ((void (*)(id,SEL,NSInteger))objc_msgSend)(s, sel_registerName("setAge:"), 18);
//    NSLog(@"name:%@, age:%ld", ((NSString *(*)(id,SEL))objc_msgSend)(s, sel_registerName("name")),((NSInteger (*)(id,SEL))objc_msgSend)(s, sel_registerName("age")));
//    NSTimer *timer = [NSTimer timerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"--->");
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];
//
//    {
//        NSString *text = @"免费为你#添加对方微信#，抓住每一段缘分机会\n\n免费为你#增加更多曝光#，让更多#和👌你条😏件#匹配的异性看见你\n\n免费享受#上线提醒特权#，你喜欢的Ta上线后，你能立刻知道";
//        NSArray *markStrings = @[@"添加对方微信",@"增加更多曝光",@"和👌你条😏件",@"上线提醒特权"];
//        [ZAStringScanner testWithString:text markStrings:markStrings];
//    }
//
//    {
//        NSString *text = @"免费为你#添加对方微信#，抓住每一段缘分机会\n\n免费为你#增加更多曝光#，让更多和你👌条件🙄匹配的异性看见你\n\n免费享受#上线提醒特权#，你喜欢的Ta上线后，#你能立刻知道";
//        NSArray *markStrings = @[@"添加对方微信",@"增加更多曝光",@"上线提醒特权"];
//        [ZAStringScanner testWithString:text markStrings:markStrings];
//    }
//
//    {
//        NSString *text = @"#免#费##";
//        NSArray *markStrings = @[@"免"];
//        [ZAStringScanner testWithString:text markStrings:markStrings];
//    }
//
//    return 0;
//}
//    NSMutableDictionary *d = [NSMutableDictionary dictionary];
////    d[@"one"] = @"1";
//    [d setObject:@"1" forKey:@"one"];
//    NSLog(@"one->%@",d[@"one"]);
//    __weak Person *pp = nil;
//    {
//        Person *p = [[Person alloc] init];
//        pp = p;
//    }
//    NSLog(@"-------");
//    pp.name = @"li ming";
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
