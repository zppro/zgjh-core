//
//  Functions.m
//  AirQueue
//
//  Created by zppro on 11-8-4.
//  Copyright 2011 codans. All rights reserved.
//

 

#import "Functions.h" 
#import "MacroFunctions.h"
#import "MBProgressHUD.h"

void ShowInfo(NSString* message){
	UIAlertView *alertDialog=[[UIAlertView alloc] initWithTitle:@"信息" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alertDialog show];
	[alertDialog release];
}

void ShowError(NSString* message){
	UIAlertView *alertDialog=[[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alertDialog show];
	[alertDialog release];
} 


NSString* FormatNullString(NSString* formatString){
    return (((id)[NSNull null]) ==  formatString)?@"":formatString;
}

NSString* GetCurrentDateString(NSString* formatString){
    NSDate* date = [NSDate date];
    return GetDateString(date,formatString);
}

NSString* GetDateString(NSDate* date, NSString* formatString){
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease]; 
    //Set the required date format
    [formatter setDateFormat:formatString];
    //Get the string date
    return [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
}

NSString* GetMonthName(NSDate* date,NSLocale* locale){
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.locale=locale;
    dateFormatter.dateFormat=@"MMMM";
    return [dateFormatter stringFromDate:date];  
}

NSString* GetMonthAbbrName(NSDate* date,NSLocale* locale){
    return [[GetMonthName(date,locale) capitalizedString] substringToIndex:3];  
}

NSString* GetWeekName(NSDate* date,NSLocale* locale){
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    dateFormatter.locale=locale;
    dateFormatter.dateFormat=@"EEEE";
    return [dateFormatter stringFromDate:date];
}

NSString* GetWeekAttrName(NSDate* date,NSLocale* locale){
    return [[GetWeekName(date,locale) capitalizedString] substringToIndex:3];
}

NSDate* ParseDateFromJsonStr(NSString *json){
    if(json == nil){
        return nil;
    }
    NSString * str = [json substringWithRange:NSMakeRange(6,10)];
    NSTimeInterval time=[str doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:time];
}

NSString* ParseDateToJsonStr(NSDate *date){
    if(date == nil){
        return nil;
    }
    return [NSString stringWithFormat:@"/Date(%.0f+0800)/",date.timeIntervalSince1970*1000];
}

NSDate* ParseDateFromString(NSString *dateString){
    return ParseDateFromStringFormat(dateString,@"yyyy-MM-dd HH:mm:ss");
}

NSDate* ParseDateFromStringFormat(NSString *dateString,NSString *formatString){
    if(dateString == nil){
        return nil;
    }
    if(formatString == nil){
        formatString = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:dateString];
} 

void PlayAudio(NSString* path){
    
    SystemSoundID soundID;	
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];	
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	AudioServicesPlaySystemSound(soundID);
}

NSString* ConvertToStringFromDateTime(NSString* jsonDateTime){ 
    NSTimeInterval time=[[jsonDateTime substringWithRange:NSMakeRange(6,10)] doubleValue];
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    [dateFormat release];
    return dateString;
}

NSNumber* ConvertToNumber(NSString* numberString){
    NSNumberFormatter * f = [[[NSNumberFormatter alloc] init] autorelease];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString:numberString];
}

NSString* ConvertToDistanceString(double distance){
    if(distance >= 100000){
        return @"异地";
    }
    return [NSString stringWithFormat:@"%.2f%@",(distance < 1000?distance:distance / 1000),(distance < 1000?@"m":@"km")];
}

id GetNextResponserToSelctor(id occurViewOrController, SEL selector){
    if ([occurViewOrController nextResponder] == nil){
        return nil;
    }
    if([[occurViewOrController nextResponder] respondsToSelector:selector]){
        return [occurViewOrController nextResponder]; 
    }
    else{
        return GetNextResponserToSelctor([occurViewOrController nextResponder],selector);
    }
}

id GetFirstResponser(id occurViewOrController){
    if ([occurViewOrController isFirstResponder]){
        return occurViewOrController;
    }
    if([occurViewOrController isKindOfClass:[UIView class]]){
        //UIView
        for (UIView *subView in ((UIView*)occurViewOrController).subviews) {
            return GetFirstResponser(subView);
        }
    }
    else{
        //UIViewController
        return GetFirstResponser(((UIViewController*)occurViewOrController).view);
    } 
    return NO;
}

BOOL IsValidMobile(NSString* mobile){
    return IsValidMobileByError(mobile,nil);
}

BOOL IsValidMobileByError(NSString* mobile,NSString** error){
     
    if([MF_Trim(mobile) length]==0){
        if(error!=nil){
            *error = @"请输入手机号码";
        }
        return FALSE;
    } 
    
    //规定以13，15，18开头的11位数字位有效手机号
    NSString *allRegex = @"^[1][358]{1}[0-9]{9}$";
    NSPredicate *testAllRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",allRegex];
    BOOL isMatch = [testAllRegex evaluateWithObject:mobile];
    if(error!=nil){
        *error = @"请输入正确的手机号码";
    }
    return isMatch;
}

BOOL IsNilOrEmpty(id obj) {
    if (obj == nil) {
        return YES;
    }
    
    // NSString
    if ([obj respondsToSelector:@selector(length)]) {
        return [obj length] == 0;
    }
    
    // NSArray, NSDictionary, NSSet
    if ([obj respondsToSelector:@selector(count)]) {
        return [obj count] == 0;
    }
    
    return NO;
}

void showHUDInfo(id delegate,UIView * view, NSString* title){
    showHUDInfoDelay(delegate,view,title,1.0f);
}

void showHUDInfoDelay(id delegate,UIView * view, NSString* title,double delayInSeconds){
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
	[view addSubview:hud];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	//HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	
	// Set custom view mode
	hud.mode = MBProgressHUDModeCustomView;
	
	hud.delegate = delegate;
	hud.labelText = title;
	
	[hud show:YES];
	[hud hide:YES afterDelay:delayInSeconds];
}
