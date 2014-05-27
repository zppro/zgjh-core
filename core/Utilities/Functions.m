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
#import "MACollectionUtilities.h"
#import "UIDevice-Hardware.h"
#import "BaseController.h"
#import "UIAlertView+BlocksKit.h"

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

void ShowConfirm(NSString* message,ConfirmContinueBlock continueBlock,ConfirmCancelBlock cancelBlock){
    UIAlertView *alertDialog = [UIAlertView alertWithTitle:@"确认对话框" message:message];
    [alertDialog addButtonWithTitle:@"继续" handler:continueBlock];
    [alertDialog addButtonWithTitle:@"取消" handler:cancelBlock];
    [alertDialog show];
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

// 正则判断电话号码地址格式
BOOL IsValidPhone(NSString *phoneNo){
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:phoneNo] == YES)
        || ([regextestcm evaluateWithObject:phoneNo] == YES)
        || ([regextestct evaluateWithObject:phoneNo] == YES)
        || ([regextestcu evaluateWithObject:phoneNo] == YES)
        || ([regextestphs evaluateWithObject:phoneNo] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

BOOL IsValidMail(NSString *mail){
    NSString *mailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    NSPredicate *mailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mailRegex];
    return [mailTest evaluateWithObject:mail];
}

NSArray* matchMobile(NSString* searchedString){
    NSRange  searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *patternMobile = @"1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}";
    NSError  *error = nil;
    NSMutableArray *results = [NSMutableArray array];
    NSRegularExpression* regexMobile = [NSRegularExpression regularExpressionWithPattern:patternMobile options:0 error:&error];
    NSArray* matches = [regexMobile matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        [results addObject:[searchedString substringWithRange:[match range]]];
    }
    return results;
}

NSArray* matchPhoneShort(NSString* searchedString){
    
    NSRange  searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *patternPhoneShort = @"\\d{6}";
    NSError  *error = nil;
    NSMutableArray *results = [NSMutableArray array];
    NSRegularExpression* regexPhoneShort = [NSRegularExpression regularExpressionWithPattern:patternPhoneShort options:0 error:&error];
    
    NSArray* matches = [regexPhoneShort matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        [results addObject:[searchedString substringWithRange:[match range]]];
    }
    return results;
    
}

NSArray* matchTel(NSString* searchedString){
    NSRange  searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *patternTel= @"0(10|2[0-5789]|\\d{3})-?\\d{7,8}";
    NSError  *error = nil;
    NSMutableArray *results = [NSMutableArray array];
    NSRegularExpression* regexTel = [NSRegularExpression regularExpressionWithPattern:patternTel options:0 error:&error];
    NSArray* matches = [regexTel matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        [results addObject:[searchedString substringWithRange:[match range]]];
    }
    return results;
}

NSArray* matchMail(NSString* searchedString){
    NSRange  searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *patternMail= @"\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+";
    NSError  *error = nil;
    NSMutableArray *results = [NSMutableArray array];
    NSRegularExpression* regexMail = [NSRegularExpression regularExpressionWithPattern:patternMail options:0 error:&error];
    NSArray* matches = [regexMail matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        [results addObject:[searchedString substringWithRange:[match range]]];
    }
    return results;
}

void CallPrompt(NSString* phoneNo){
    if([moApp canOpenURL:[NSURL URLWithString:@"telprompt://"]]){
        [moApp openURL:[NSURL URLWithString:JOIN(@"telprompt:", phoneNo)]];
    }
    else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您的设备不支持拨号." delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [Notpermitted show];
        [Notpermitted release];
    }
}

void SMSPrompt(id phoneNos,BaseController *ctl){
    MFMessageComposeViewController *picker = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([phoneNos isKindOfClass:[NSArray class]]){
        [picker setRecipients:phoneNos];
    }
    else {
        [picker setRecipients:[NSArray arrayWithObject:phoneNos]];
    }
    [picker setBody:@""];
    [ctl presentSms:picker From:ctl];
}

void MailPrompt(id mails,BaseController *ctl){
    MFMailComposeViewController *picker = [[[MFMailComposeViewController alloc] init] autorelease];
    if([mails isKindOfClass:[NSArray class]]){
        [picker setToRecipients:mails];
    }
    else {
        [picker setToRecipients:[NSArray arrayWithObject:mails]];
    }
    [picker setSubject:@""];
    [picker setMessageBody:@"" isHTML:NO];
    [ctl presentMail:picker From:ctl];
}

void SMS(NSString* phoneNo){
    if([moApp canOpenURL:[NSURL URLWithString:@"sms://"]]){
        [moApp openURL:[NSURL URLWithString:JOIN(@"sms:", phoneNo)]];
    }
    else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"警告" message:@"您的设备不支持发送短信." delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [Notpermitted show];
        [Notpermitted release];
    }
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
