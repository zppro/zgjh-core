//
//  UIDevice+ZP.h
//  core
//
//  Created by zppro on 12-8-17.
//  Copyright 2012年 zppro.com. All rights reserved.
//

#import "UIDevice+ZP.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSBundle+ECUtilities.h"

@implementation UIDevice (ZP)

int instr(NSString *searchIn,NSString *searchFor, int startingAt)
{
	NSRange searchRange;
	int retVal;
	
	searchRange.location = startingAt;
	searchRange.length = [searchIn length] - startingAt;
	
	NSRange foundRange = [searchIn rangeOfString:searchFor options:0  range:searchRange];
	if(foundRange.length > 0){
		retVal = foundRange.location;
	}else{
		retVal = -1;
	}
	
	return retVal;
}


- (int)deviceType {
    int type = 0;
    //DebugLog(@"Model position:%d",instr(self.model,@"Simulator",1));
	if (instr(self.model,@"Simulator",1)>=1) {
		type=4;//模拟器
	}
    else if (instr(self.model,@"iPad",0)>=0) {
		type=1;
	}
    else if (instr(self.model,@"iPod",0)>=0) {
		type=2;
	}
	else{
		type=3; //iphone
	}
    return type;
}

- (NSString *)bundleVersion {
    return [[NSBundle mainBundle] bundleBuild];
    //[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (NSString *)IP {
    InitAddressesC();
    GetIPAddressesC();
    GetHWAddressesC();
    
    return [NSString stringWithFormat:@"%s", ip_namesC[1]];
}

- (NSString *)MAC {
    return [self macaddress];
}

@end
