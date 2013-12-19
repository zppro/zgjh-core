//
//  e0571DES.h
//  dWork
//
//  Created by yangxh on 11-6-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCryptor.h>
#include <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

#define e0571DES CSe0571DES // for hack link error

@interface e0571DES : NSObject {
    
}


// Basic DES
+ (NSData *)encryptData:(NSData *)data key:(NSString *)key;
+ (NSData *)decryptData:(NSData *)data key:(NSString *)key;

// Base64
+ (NSString *)base64EncodeString:(NSString *)str Key:(NSString *)key;
+ (NSString *)base64DecodeString:(NSString *)str Key:(NSString *)key;

@end
