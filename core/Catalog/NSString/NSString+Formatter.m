//
//  NSString+Formatter.m
//  core
//
//  Created by zppro on 13-1-16.
//
//

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

+(NSString*)guidString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}

-(NSUInteger) indexOf:(NSString *) subStr{
    NSRange range = [self rangeOfString:subStr];
    if (range.length == 0){
        return -1;
    }
    else{
        return range.location;
    } 
}


@end
