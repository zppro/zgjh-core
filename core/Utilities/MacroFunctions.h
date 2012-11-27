//
//  MacroFunctions.h
//  CheckDaily
//
//  Created by 钟 平 on 11-9-11.
//  Copyright 2011年 zppro. All rights reserved.
//

#define LayoutDebug

#ifndef DEBUG
#define DEBUG
#endif

#ifdef RELEASE
#undef DEBUG
#endif

#ifdef DEBUG 
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#define DebugLog( s, ... ) NSLog( @"<<<<%p %@:(%d) %s>>>>\n%@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#define DebugLog(...)  GTMLoggerDebug(__VA_ARGS__)//LOG_DEBUG(__VA_ARGS__)
#else
#define DLog( s, ... ) do { } while(0);
//#define DebugLog( s, ... )  do { } while(0);
#define DebugLog(...) do {} while(0);
#endif

#ifndef CheckDaily_MacroFunctions_h
#define CheckDaily_MacroFunctions_h

// 空guid
#define EMPTY_GUID @"00000000-0000-0000-0000-000000000000"

#pragma mark - EnvirormentHelper

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SYSTEM_VERSION_LIKE(v) [[UIDevice currentDevice].systemVersion hasPrefix:v]

#define IS_IOS_3 SYSTEM_VERSION_LIKE(@"3.")

#define IS_IOS_4 SYSTEM_VERSION_LIKE(@"4.")
#define IS_IOS_GREATER_THAN_4 SYSTEM_VERSION_GREATER_THAN(@"4.")
#define IS_IOS_4_2 SYSTEM_VERSION_LIKE(@"4.2.")
#define IS_IOS_GREATER_THAN_4_2_1 SYSTEM_VERSION_GREATER_THAN(@"4.2.1")
#define IS_IOS_4_3 SYSTEM_VERSION_LIKE(@"4.3.")

#define IS_IOS_5 SYSTEM_VERSION_LIKE(@"5.")

#define IS_IPHONE ([UIDevice currentDevice].platformType == UIDevice1GiPod || [UIDevice currentDevice].platformType == UIDevice2GiPod || [UIDevice currentDevice].platformType == UIDevice3GiPod || [UIDevice currentDevice].platformType == UIDevice4GiPod || [UIDevice currentDevice].platformType == UIDeviceUnknowniPod)
#define IS_IPHONE_1 ([UIDevice currentDevice].platformType == UIDevice1GiPhone)
#define IS_IPHONE_3 ([UIDevice currentDevice].platformType == UIDevice3GiPhone)
#define IS_IPHONE_3S ([UIDevice currentDevice].platformType == UIDevice3GSiPhone)
#define IS_IPHONE_4 ([UIDevice currentDevice].platformType == UIDevice4iPhone)
#define IS_IPHONE_4S ([UIDevice currentDevice].platformType == UIDevice4SiPhone)

#define IS_IPAD ([UIDevice currentDevice].platformType == UIDevice1GiPad || [UIDevice currentDevice].platformType == UIDevice2GiPad || [UIDevice currentDevice].platformType == UIDevice3GiPad || [UIDevice currentDevice].platformType ==UIDeviceUnknowniPad)
#define IS_IPAD_1 ([UIDevice currentDevice].platformType == UIDevice1GiPad)
#define IS_IPAD_2 ([UIDevice currentDevice].platformType == UIDevice2GiPad)
#define IS_IPAD_3 ([UIDevice currentDevice].platformType == UIDevice3GiPad)

#define IS_IPOD ([UIDevice currentDevice].platformType == UIDevice1GiPod || [UIDevice currentDevice].platformType == UIDevice2GiPod || [UIDevice currentDevice].platformType == UIDevice3GiPod || [UIDevice currentDevice].platformType == UIDevice4GiPod || [UIDevice currentDevice].platformType == UIDeviceUnknowniPod)
#define IS_IPOD_1 ([UIDevice currentDevice].platformType == UIDevice1GiPod)
#define IS_IPOD_2 ([UIDevice currentDevice].platformType == UIDevice2GiPod)
#define IS_IPOD_3 ([UIDevice currentDevice].platformType == UIDevice3GiPod)
#define IS_IPOD_4 ([UIDevice currentDevice].platformType == UIDevice4GiPod)

//角度与弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define RADIANS_TO_DEGREES(r) (r * 180 / M_PI)

// MARK: - Number Helper
#define NF(f) [NSNumber numberWithFloat:f]
#define NI(i) [NSNumber numberWithInt:i]
#define NB(b) [NSNumber numberWithBool:b]

// MARK: - Dictionary Helper
#define DO(dict, key) [dict objectForKey:key]
#define DB(dict, key) [DO(dict, key) boolValue]
#define DS(dict, key) ((NSString *)DO(dict, key))
#define DA(dict, key) ((NSArray *)DO(dict, key))
#define DN(dict, key) ((NSNumber *)DO(dict, key))
#define DI(dict, key) [DO(dict, key) intValue]
#define DF(dict, key) [DO(dict, key) floatValue]

#pragma mark - Helper
#define IS_NIL_OR_EMPTY(obj) IsNilOrEmpty(obj)

// MARK: - String Helper
#define NULL_STR(str, default) (str ?: default)
#define EMPTY_STR(str, default) (str ? (str.length == 0 ? default : str ) : default)
#define NULL_STR_DEFAULT_TO_EMPTY(str) NULL_STR(str, @"")
#define SI(i) [NSString stringWithFormat:@"%d", i]
#define SNI(ni) [NSString stringWithFormat:@"%d", [ni intValue]]
#define S_A_T(a,t) [NSString stringWithFormat:@"%d/%d", a,t]
// MARK: - Path Helper
#define DOCUMENTS_DIR ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])

// MARK: - Block Helper
#if NS_BLOCKS_AVAILABLE

typedef void (^CompletionBlock)(NSDictionary *dict);
typedef void (^SuccessBlock)(id result);
typedef void (^FailedBlock)(NSError *error);
typedef void (^FinalBlock)(void);

#define SAFE_BLOCK_CALL_NO_P(b) (b == nil ?: b())
#define SAFE_BLOCK_CALL(b, p) (b == nil ? : b(p) )

#endif

#pragma mark - Release
#define MCRelease(x) [x release], x = nil

//颜色

#define MF_ColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MF_ColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define MF_ColorFromRGBA2(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define MF_ColorFromString2(x) MF_ColorFromRGB(\
[MF_Trim([[[x substringWithRange:NSMakeRange(1, [x length]-1)] componentsSeparatedByString:@","] objectAtIndex:0]) floatValue], \
[MF_Trim([[[x substringWithRange:NSMakeRange(1, [x length]-1)] componentsSeparatedByString:@","] objectAtIndex:1]) floatValue], \
[MF_Trim([[[x substringWithRange:NSMakeRange(1, [x length]-1)] componentsSeparatedByString:@","] objectAtIndex:2]) floatValue])

#define MF_ColorFromString(x) [x isEqualToString: @"transparent"]?[UIColor clearColor]:MF_ColorFromString2(x)

#define MF_StringFromColor(color) [NSString stringWithFormat:@"{%d,%d,%d}",\
[[[[NSString stringWithFormat:@"%@",color] componentsSeparatedByString:@" "] objectAtIndex:1] intValue] * 255,\
[[[[NSString stringWithFormat:@"%@",color] componentsSeparatedByString:@" "] objectAtIndex:2] intValue] * 255,\
[[[[NSString stringWithFormat:@"%@",color] componentsSeparatedByString:@" "] objectAtIndex:3] intValue] * 255]

//资源
//#define MF_Png(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]
//#define MF_Plist(name) [[NSBundle mainBundle] pathForResource:name ofType:@"plist"]
#define MF_PngOfDefaultSkin(imageName) MF_Png(imageName, @"Default")
#define MF_Png(imageName, skinName) [PHResourceManager getImageWithName:imageName andSkinName:skinName]
#define MF_APng(imageName) [PHResourceManager getImageWithName:imageName]
#define MF_Resource(name) [PHResourceManager getResourcePath:name]
#define MF_Plist(name) [PHResourceManager getResourcePath:[NSString stringWithFormat:@"%@.plist",name]]
#define MF_PngFromMainBundle(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]
#define MF_FilePath(fileName) [PHResourceManager getFilePath:fileName]
//字符串
#define MF_Trim(x) [x stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]
#define MF_SWF(FORMAT, ...) [NSString stringWithFormat:FORMAT, __VA_ARGS__]
#define MF_Replace(raw,f,r) [raw stringByReplacingOccurrencesOfString:f withString:r]
//时间
#define MF_DateAddDays(date,day) [date dateByAddingTimeInterval:60*60*24*day]
#define MF_IsWeekend(date) [GetDateString(date,@"e") isEqualToString: @"1"] \
 || [GetDateString(date,@"e") isEqualToString: @"7"]

#endif 

//file
#define MF_ResourceDocument() [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Documents"]
#define MF_DocumentFolder() [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define MF_FileExists(fullPath) [[NSFileManager defaultManager] fileExistsAtPath:fullPath]
 
//设置
#define AppSettingInteger(key) [[NSUserDefaults standardUserDefaults] integerForKey:key]
#define AppSetting(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]


//通知处理
#define addN(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])

#define removeNObserverWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])

#define removeNObserver() ([[NSNotificationCenter defaultCenter] removeObserver:self])

#define postN(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])

#define postNWithObj(_name,_obj)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])

#define postNWithInfos(_name,_obj,_infos)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])

//定时器
#define addT(_selector,_second)\
[NSTimer scheduledTimerWithTimeInterval:_second target:self selector:_selector userInfo: nil repeats: YES]

#define random1(x) (arc4random() % x)
#define random2(x) ((arc4random() % x) + 1)

//格式化
#define center(x,y) ((x - y)/2.f)
#define retina(x) (x/2.f)

//初始化
#define makeView(x,y,w,h) [[[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeScrollView(x,y,w,h) [[[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeLabel(x,y,w,h) [[[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeImageViewByFrame(f) [[[UIImageView alloc] initWithFrame:f] autorelease]
#define makeImageView(x,y,w,h) [[[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeButtonByFrame(f) [[[UIButton alloc] initWithFrame:f] autorelease]
#define makeButton(x,y,w,h) [[[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeTextView(x,y,w,h) [[[UITextView alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]
#define makeTableView(x,y,w,h) [[[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h)] autorelease]