//
//  ZPUIActionSheet.h
//  core
//
//  Created by zppro on 12-11-30.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZPUIActionSheet : UIActionSheet

@property(nonatomic,retain)UIView    *contentView; 

+(id)zSheetWithHeight:(float)height withSheetTitle:(NSString*)title;

-(id)initWithHeight:(float)height withSheetTitle:(NSString*)title;
-(void)done;
-(void)docancel;
@end
