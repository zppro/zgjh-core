//
//  Functions.h
//  AirQueue
//
//  Created by zppro on 11-8-4.
//  Copyright 2011 codans. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import "ABAddressBook.h"

@class BaseController;

typedef enum
{
	DialogButton_Ok=1 << 0,			//确定
	DialogButton_Cancel= 1 << 1,		//取消
    DialogButton_Yes= 1 << 2,		//是
    DialogButton_No = 1 << 3         //否
    
} DialogButton;

typedef void(^ConfirmContinueBlock)(void);
typedef void(^ConfirmCancelBlock)(void);

void ShowInfo(NSString* message);

void ShowError(NSString* message);

void ShowConfirm(NSString* message,ConfirmContinueBlock continueBlock,ConfirmCancelBlock cancelBlock);

NSString* FormatNullString(NSString* formatString);

NSString* GetCurrentDateString(NSString* formatString);

NSString* GetDateString(NSDate* date, NSString* formatString);

NSString* GetMonthName(NSDate* date,NSLocale* locale);

NSString* GetMonthAbbrName(NSDate* date,NSLocale* locale);

NSString* GetWeekName(NSDate* date,NSLocale* locale);

NSString* GetWeekAttrName(NSDate* date,NSLocale* locale);

NSDate* ParseDateFromJsonStr(NSString *json);

NSString* ParseDateToJsonStr(NSDate *date);

NSDate* ParseDateFromString(NSString *dateString);

NSDate* ParseDateFromStringFormat(NSString *dateString, NSString* formatString);

void PlayAudio(NSString* filePath);

NSString* ConvertToStringFromDateTime(NSString* jsonDateTime);

NSNumber* ConvertToNumber(NSString* numberString);

NSString* ConvertToDistanceString(double distance);

id GetNextResponserToSelctor(id occurViewOrController, SEL selector);

id GetFirstResponser(id occurViewOrController);

BOOL IsValidMobile(NSString* mobile);

BOOL IsValidMobileByError(NSString* mobile,NSString** error);

// 正则判断手机号码地址格式
BOOL IsValidPhone(NSString *phoneNo);

// 正则判断电邮格式
BOOL IsValidMail(NSString *mail);

NSArray* matchMobile(NSString* searchedString);
NSArray* matchPhoneShort(NSString* searchedString);
NSArray* matchTel(NSString* searchedString);
NSArray* matchMail(NSString* searchedString);

void CallPrompt(NSString* phoneNo);
void SMSPrompt(id phoneNos,BaseController *ctl);
void MailPrompt(id mails,BaseController *ctl);
void SMS(NSString* phoneNo);

BOOL IsNilOrEmpty(id obj);
 
void showHUDInfo(id delegate,UIView * view, NSString* title);
void showHUDInfoDelay(id delegate,UIView * view, NSString* title,double delayInSeconds);
 