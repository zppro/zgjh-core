/*
 Copyright (C) 2009 Stig Brautaset. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
   to endorse or promote products derived from this software without specific
   prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSObject+JSON.h"
#import <objc/runtime.h>
#import "JSONKit.h"
#import "MacroFunctions.h"
#import "NXJsonParser.h"
#import "NXJsonSerializer.h"

@implementation NSArray (NSArray_JsonWriting)

- (NSString *)JSONRepresentation_NX {
    return [NXJsonSerializer serialize:self];
}


- (NSString *)JSONRepresentation {
    return [self JSONString]; //JSONKit 
}

@end 

@implementation NSDictionary (NSDictionary_JsonWriting)

- (NSString *)JSONRepresentation_NX {
    return [NXJsonSerializer serialize:self];
}

- (NSString *)JSONRepresentation {
    return [self JSONString]; //JSONKit
    
}

@end

@implementation NSObject (NSObject_JsonWriting)

// NOT SUPPORT INNER NSARRAY OR NSDICTIONARY
//- (NSString *)customJSONRepresentation {
//    
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    if (outCount == 0) { //没有属性???
//        return [self description];
//    }
//    
//    NSMutableDictionary *mapings = [[[NSMutableDictionary alloc] initWithCapacity:outCount] autorelease];
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        NSString *key = [[NSString alloc] initWithCString:property_getName(property)
//                                                 encoding:NSUTF8StringEncoding];
//        id value = [self valueForKey:key];
//        NSString *str;
//        
//        if (value == nil) {
//            str = @"";
//        } else {
//            str = [value JSONString];
//        }
//        
//        [mapings setObject:str forKey:key];
//        [key release];
//    }
//    
//    return [mapings JSONRepresentation];
//}

- (NSString *)customJSONRepresentation {
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    if (outCount == 0) { //没有属性???
        return [self description];
    }
    
    NSMutableDictionary *mapings = [[[NSMutableDictionary alloc] initWithCapacity:outCount] autorelease];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property)
                                                 encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:key];
        NSString *str;
        
        if (value == nil) {
            str = @"";
        } else {
            str = [value JSONString];
        }
        
        [mapings setObject:str forKey:key];
        [key release];
    }
    
    return [mapings JSONRepresentation];
}

@end



@implementation NSString (NSString_JsonParsing)

- (id)JSONValue_NX {
    
    // NXJson
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NXJsonParser *parser = [[NXJsonParser alloc] initWithData:data];
    NSError *error = nil;
    id result = [parser parse:&error ignoreNulls:YES];
    if (error) {
        //DebugLog(@"-JSONValue failed. Source is: %@", self);
        return nil;
    }
    return result;
    
}

- (id)JSONValue {
    
    // NXJson
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NXJsonParser *parser = [[NXJsonParser alloc] initWithData:data];
    NSError *error = nil;
    id result = [parser parse:&error ignoreNulls:YES];
    [parser release];
    if (error) {
        DebugLog(@"-JSONValue failed. Source is: %@", self);
        return nil;
    }
    return result; 
}


@end
