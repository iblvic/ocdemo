//
//  SunnyInterview.h
//  ocdemo
//
//  Created by haosimac on 2023/7/19.
//

#import <Foundation/Foundation.h>

@interface Father : NSObject

@end


@interface Son : Father

@end

@interface NSObject (Sark)
+ (void)foo;
+ (void)test;
@end


@interface Sark : NSObject
@property (nonatomic, copy) NSString *name;
- (void)speak;
@end

void testEntry(void);
