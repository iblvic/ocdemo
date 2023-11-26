//
//  TestBlock.h
//  ocdemo
//
//  Created by haosimac on 2023/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestB : NSObject

@property (nonatomic, copy) void(^block)(void);

- (void)test;

@end

NS_ASSUME_NONNULL_END
