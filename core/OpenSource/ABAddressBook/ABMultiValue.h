/*
 * ABMultiValue.h
 * iPhoneContacts
 * 
 * Created by Jim Dovey on 6/6/2009.
 * 
 * Copyright (c) 2009 Jim Dovey
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 
 * Neither the name of the project's author nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import <Foundation/Foundation.h>
#import <AddressBook/ABMultiValue.h>
#import <AddressBook/ABPerson.h>
#import "ABRefInitialization.h"

@interface ABMultiValue : NSObject <ABRefInitialization, NSCopying, NSMutableCopying>
{
    ABMultiValueRef _ref;
}

@property (nonatomic, readonly, getter=getMultiValueRef) ABMultiValueRef multiValueRef;

@property (nonatomic, readonly) ABPropertyType propertyType;
@property (nonatomic, readonly) NSUInteger count;

- (id) valueAtIndex: (NSUInteger) index;
- (NSArray *) allValues;

- (NSString *) labelAtIndex: (NSUInteger) index;
- (NSString *) localizedLabelAtIndex: (NSUInteger) index;

- (NSUInteger) indexForIdentifier: (ABMultiValueIdentifier) identifier;
- (ABMultiValueIdentifier) identifierAtIndex: (NSUInteger) index;

// returns the index of the first occurrence of the specified value
- (NSUInteger) indexOfValue: (id) value;

@end

#pragma mark -

@interface ABMutableMultiValue : ABMultiValue

- (id) initWithPropertyType: (ABPropertyType) type;

- (BOOL) addValue: (id) value withLabel: (NSString *) label identifier: (ABMultiValueIdentifier *) outIdentifier;
- (BOOL) insertValue: (id) value withLabel: (NSString *) label atIndex: (NSUInteger) index identifier: (ABMultiValueIdentifier *) outIdentifier;
- (BOOL) addMultiValue: (ABMultiValue *)multivalue;

- (BOOL) removeValueAndLabelAtIndex: (NSUInteger) index;

- (BOOL) replaceValueAtIndex: (NSUInteger) index withValue: (id) value;
- (BOOL) replaceLabelAtIndex: (NSUInteger) index withLabel: (NSString *) label;

@end
