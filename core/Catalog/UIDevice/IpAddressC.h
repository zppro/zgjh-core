//
//  IpAddress.h
//  HttpTest
//
//  Created by shrek on 10-9-8.
//  Copyright 2010 e0571.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAXADDRS	32

extern char *if_namesC[MAXADDRS];
extern char *ip_namesC[MAXADDRS];
extern char *hw_addrsC[MAXADDRS];
extern unsigned long ip_addrsC[MAXADDRS];

//#define IpAddress IpAddressC // for hack
//
//@interface IpAddress : NSObject {
//
//}

// Function prototypes

void InitAddressesC(void);
void FreeAddressesC(void);
void GetIPAddressesC(void);
void GetHWAddressesC(void);

//@end
