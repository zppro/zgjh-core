//
//  SkinElement.m
//  AirHotel
//
//  Created by Tan Michael on 12-2-7.
//  Copyright (c) 2012年 ponhoo. All rights reserved.
//

#import "SkinElement.h"
#import "EnumStrings.h"
#import "PHResourceManager.h"
#import "MacroFunctions.h"
#import "UIView+Motion.h"
@interface SkinElement()
- (id)generateView;
- (id)generateLabel;
- (id)generateButton;
- (id)generateTextField;
- (id)generateTextView;
@end

@implementation SkinElement

@synthesize name = _name;
@synthesize frame = _frame;
@synthesize tag = _tag;
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize textAlignment = _textAlignment;
@synthesize enabled = _enabled;
@synthesize hidden = _hidden;
@synthesize backgroundColor = _backgroundColor;
@synthesize image = _image;
@synthesize backImage = _backImage;
@synthesize elementType = _elementType;

- (id)initWithDictionary:(NSDictionary *)elementConfig {
    self = [super init];
    if (self) {
        NSString *objName = MF_Trim([elementConfig objectForKey:@"Name"]);
        if (![objName isEqualToString:@""]) {
            self.name = objName;
        }
        NSString *objFrame = MF_Trim([elementConfig objectForKey:@"Frame"]);
        if (![objFrame isEqualToString:@""]) {
            self.frame = objFrame;
        }
        self.tag = [elementConfig objectForKey:@"Tag"];
        NSString *objText = MF_Trim([elementConfig objectForKey:@"Title"]);
        if (![objText isEqualToString:@""]) {
            self.text = objText;
        }
        self.font = [elementConfig objectForKey:@"Font"];
        NSString *objTextColor = MF_Trim([elementConfig objectForKey:@"TextColor"]);
        if (![objTextColor isEqualToString:@""]) {
            self.textColor = objTextColor;
        }
        NSString *objTextAlignment = MF_Trim([elementConfig objectForKey:@"TextAlignment"]);
        if (![objTextColor isEqualToString:@""]) {
            self.textAlignment = objTextAlignment;
        }
        NSString *objEnabled = MF_Trim([elementConfig objectForKey:@"Enabled"]);
        if ([objEnabled isEqualToString:@"NO"]) {
            self.enabled = @"NO";
        } else {
            self.enabled = @"YES";
        }
        NSString *objHidden = MF_Trim([elementConfig objectForKey:@"Hidden"]);
        if ([objHidden isEqualToString:@"YES"]) {
            self.hidden = @"YES";
        } else {
            self.hidden = @"NO";
        }
        NSString *objBackgroundColor = MF_Trim([elementConfig objectForKey:@"BackgroundColor"]);
        if (![objBackgroundColor isEqualToString:@""]) {
            self.backgroundColor = objBackgroundColor;
        }
        NSString *objImage = MF_Trim([elementConfig objectForKey:@"Image"]);
        if (![objImage isEqualToString:@""]) {
            self.image = objImage;
        }
        NSString *objBackImage = MF_Trim([elementConfig objectForKey:@"BackImage"]);
        if (![objBackImage isEqualToString:@""]) {
            self.backImage = objBackImage;
        }
        NSString *objElementType = MF_Trim([elementConfig objectForKey:@"ElementType"]);
        if (![objElementType isEqualToString:@""]) {
            self.elementType = objElementType;
        }
    }
    return self;
}

- (id)generateObject {
    if ([_elementType isEqualToString:NSStringFromClass([UIView class])]) {
        return [self generateView];
    } else if ([_elementType isEqualToString:NSStringFromClass([UILabel class])]) {
        return [self generateLabel];
    } else if ([_elementType isEqualToString:NSStringFromClass([UIButton class])]) {
        return [self generateButton];
    } else if ([_elementType isEqualToString:NSStringFromClass([UITextField class])]) {
        return [self generateTextField];
    } else if ([_elementType isEqualToString:NSStringFromClass([UITextView class])]) {
        return [self generateTextView];
    } else {
        return nil;
    }
}

- (id)generateView {
    UIView *view = [[[UIView alloc] initWithFrame:CGRectFromString(_frame)] autorelease];
    [view setTag:[_tag integerValue]];
    [view setHidden:[_hidden boolValue]];
    if (_backgroundColor) {
        [view setBackgroundColor:MF_ColorFromString(_backgroundColor)];
    }
    return view;
}

- (id)generateLabel {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectFromString(_frame)] autorelease];
    [label setTag:[_tag integerValue]];
    [label setEnabled:[_enabled boolValue]];
    [label setHidden:[_hidden boolValue]];
    if (_text) {
        [label setText:_text];
    }
    if (_font) {
        [label setFont:[UIFont systemFontOfSize:[_font floatValue]]];
    }
    if (_textColor) {
        [label setTextColor:MF_ColorFromString(_textColor)];
    }
    if (_textAlignment) {
        [label setTextAlignment:[EnumStrings UITextAlignmentFromString:_textAlignment]];
    }
    if (_backgroundColor) {
        [label setBackgroundColor:MF_ColorFromString(_backgroundColor)];
    }
    return label;
}

- (id)generateButton {
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectFromString(_frame)] autorelease];
    [button setTag:[_tag integerValue]];
    [button setEnabled:[_enabled boolValue]];
    [button setHidden:[_hidden boolValue]];
    if (_text) {
        [button setTitle:_text forState:UIControlStateNormal];
    }
    if (_textColor) {
        [button setTitleColor:MF_ColorFromString(_textColor) forState:UIControlStateNormal];
    }
    if (_textAlignment) {
        [button.titleLabel setTextAlignment:[EnumStrings UITextAlignmentFromString:_textAlignment]];
    }
    if (_backgroundColor) { 
        [button setBackgroundColor:MF_ColorFromString(_backgroundColor)];
    }
    if (_image) {
        [button setImage:MF_PngOfDefaultSkin(_image) forState:UIControlStateNormal];
    }
    if (_backImage) {
        [button setBackgroundImage:MF_PngOfDefaultSkin(_backImage) forState:UIControlStateNormal];
    }
    return button;
}

- (id)generateTextField {
    UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectFromString(_frame)] autorelease];
    [textField setTag:[_tag integerValue]];
    [textField setEnabled:[_enabled boolValue]];
    [textField setHidden:[_hidden boolValue]];
    if (_text) {
        [textField setText:_text];
    }
    if (_textColor) {
        [textField setTextColor:MF_ColorFromString(_textColor)];
    }
    if (_textAlignment) {
        [textField setTextAlignment:[EnumStrings UITextAlignmentFromString:_textAlignment]];
    }
    if (_backgroundColor) {
        [textField setBackgroundColor:MF_ColorFromString(_backgroundColor)];
    }
    if (_backImage) {
        [textField setBackground:MF_PngOfDefaultSkin(_backImage)];
    }
    return textField;
}

- (id)generateTextView {
    UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectFromString(_frame)] autorelease];
    [textView setTag:[_tag integerValue]];
    [textView setHidden:[_hidden boolValue]];
    if (_text) {
        [textView setText:_text];
    }
    if (_textColor) {
        [textView setTextColor:MF_ColorFromString(_textColor)];
    }
    if (_textAlignment) {
        [textView setTextAlignment:[EnumStrings UITextAlignmentFromString:_textAlignment]];
    }
    if (_backgroundColor) {
        [textView setBackgroundColor:MF_ColorFromString(_backgroundColor)];
    }
    return textView;
}

- (void)dealloc {
    [_name release];
    [_frame release];
    [_tag release];
    [_text release];
    [_font release];
    [_textColor release];
    [_textAlignment release];
    [_enabled release];
    [_hidden release];
    [_backgroundColor release];
    [_image release];
    [_backImage release];
    [_elementType release];
    
    [super dealloc];
}

@end
