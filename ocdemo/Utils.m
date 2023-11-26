//
//  Utils.m
//  ocdemo
//
//  Created by haosimac on 2023/11/25.
//

#import <Foundation/Foundation.h>


void documentPath(char *p, char *append) {
    if (p == NULL) {
        return;
    }
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSInteger len = [path lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    strcpy(p, path.UTF8String);
    strcat(p, append);
}
