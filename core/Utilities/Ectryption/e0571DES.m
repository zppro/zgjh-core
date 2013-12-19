//
//  e0571DES.m
//  dWork
//
//  Created by yangxh on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "e0571DES.h"


@interface e0571DES() 
+ (NSData *)DES:(NSData *)data Operation:(CCOperation)operation Key:(NSString *)key;
@end

@implementation e0571DES

+ (NSData *)encryptData:(NSData *)data key:(NSString *)key {
    return [self DES:data Operation:kCCEncrypt Key:key];
}

+ (NSData *)decryptData:(NSData *)data key:(NSString *)key {
    return [self DES:data Operation:kCCDecrypt Key:key];
}

+ (NSString *)base64EncodeString:(NSString *)str Key:(NSString *)key {
    //NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *source = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptData = [self encryptData:source key:key];
    NSString *base64 = [GTMBase64 stringByEncodingData:encryptData];
    return base64;
}

+ (NSString *)base64DecodeString:(NSString *)str Key:(NSString *)key {
    //NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *decodeBase64 = [GTMBase64 decodeString:str];
    NSData *decryptData = [self decryptData:decodeBase64 key:key];
    NSString *decryptStr = [NSString stringWithCString:[decryptData bytes] encoding:NSUTF8StringEncoding];
    return decryptStr;
}

+ (NSData *)DES:(NSData *)data Operation:(CCOperation)operation Key:(NSString *)key {
    NSData *opData = [data retain];
    NSUInteger dataLength = [opData length];
    const void *dataIn = [opData bytes];
    size_t bufferSize = dataLength + kCCKeySizeDES;
    char *buffer = malloc(bufferSize);
    
    char keyPtr[kCCKeySizeDES + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmDES,
                                            kCCOptionECBMode | kCCOptionPKCS7Padding,
                                            keyPtr,
                                            kCCKeySizeDES,
                                            NULL,
                                            dataIn,
                                            dataLength,
                                            buffer,
                                            bufferSize,
                                            &numBytesEncrypted);
    [opData release];
    if (cryptorStatus != kCCSuccess) {
        free(buffer);
        return nil;
    }
    
    return [NSData dataWithBytes:buffer length:numBytesEncrypted];
}

@end
