//
// BZGFormField.m
//
// Copyright (c) 2013 Ben Guo
//
// https://github.com/benzguo/BZGFormField
//

#import "BZGFormField.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

// relative to self.frame.height
#define DEFAULT_LEFT_TEXT_PADDING 0.2
#define DEFAULT_LEFT_INDICATOR_INACTIVE_ASPECT_RATIO 0.2
#define DEFAULT_LEFT_INDICATOR_ACTIVE_ASPECT_RATIO 0.8
#define DEFAULT_NONE_COLOR UIColorFromRGB(0x95A5A6)
#define DEFAULT_VALID_COLOR UIColorFromRGB(0x2ECC71)
#define DEFAULT_INVALID_COLOR UIColorFromRGB(0xE74C3C)

@implementation BZGFormField {
    CGFloat _currentLeftIndicatorAspectRatio;
    BZGLeftIndicatorState _currentLeftIndicatorState;
    BZGFormFieldState _currentFormFieldState;

    BZGTextValidationBlock _textValidationBlock;
}
@synthesize textField;
@synthesize leftIndicator;
@synthesize alertView;
@synthesize leftIndicatorInvalidColor;
@synthesize leftIndicatorValidColor;
@synthesize leftIndicatorNoneColor;

- (void)dealloc {
    self.textField = nil;
    self.leftIndicator = nil;
    self.alertView = nil;
    self.leftIndicatorInvalidColor = nil;
    self.leftIndicatorValidColor = nil;
    self.leftIndicatorNoneColor = nil;
    [super dealloc];
}

#pragma mark - Public

- (BZGLeftIndicatorState)leftIndicatorState
{
    return _currentLeftIndicatorState;
}

- (BZGFormFieldState)formFieldState
{
    return _currentFormFieldState;
}


- (void)setTextValidationBlock:(BZGTextValidationBlock)block
{
    _textValidationBlock = [block copy];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup

- (void)setup
{
    self.leftIndicatorInactiveWidth = DEFAULT_LEFT_INDICATOR_INACTIVE_ASPECT_RATIO;
    self.leftIndicatorActiveWidth = DEFAULT_LEFT_INDICATOR_ACTIVE_ASPECT_RATIO;
    self.leftIndicatorRightPadding = DEFAULT_LEFT_TEXT_PADDING;
    _currentLeftIndicatorAspectRatio = self.leftIndicatorInactiveWidth;
    _textValidationBlock = ^BOOL(NSString *text) { return YES; };

    self.leftIndicatorInvalidColor = DEFAULT_INVALID_COLOR;
    self.leftIndicatorValidColor = DEFAULT_VALID_COLOR;
    self.leftIndicatorNoneColor = DEFAULT_NONE_COLOR;

    self.textField = [[[UITextField alloc] init] autorelease];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.text = @" ";
    [self addSubview:self.textField];
    

    self.leftIndicator = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftIndicator.titleLabel.textColor = [UIColor whiteColor];
    [self.leftIndicator addTarget:self
                           action:@selector(leftIndicatorTouchDown)
                 forControlEvents:UIControlEventTouchDown];
    [self.leftIndicator addTarget:self
                           action:@selector(leftIndicatorTouchUp)
                 forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self addSubview:self.leftIndicator];
    [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive
                    formFieldState:BZGFormFieldStateNone
                          animated:NO];
    self.textField.text = @"";

    self.alertView = [[[UIAlertView alloc] initWithTitle:@""
                                                message:@""
                                               delegate:self
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil] autorelease];
    self.alertView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification object:nil];

}

#pragma mark - Drawing

- (void)updateLeftIndicatorState:(BZGLeftIndicatorState)leftIndicatorState
                  formFieldState:(BZGFormFieldState)formFieldState
                        animated:(BOOL)animated
{
    BOOL shouldAnimate = (_currentLeftIndicatorState && !leftIndicatorState) || animated;
    _currentLeftIndicatorState = leftIndicatorState;
    _currentFormFieldState = formFieldState;
    switch (leftIndicatorState) {
        case BZGLeftIndicatorStateInactive:
            self.leftIndicator.userInteractionEnabled = NO;
            [self updateLeftIndicatorAspectRatio:self.leftIndicatorInactiveWidth animated:shouldAnimate];
            break;
        case BZGLeftIndicatorStateActive:
        default:
            self.leftIndicator.userInteractionEnabled = YES;
            [self updateLeftIndicatorAspectRatio:self.leftIndicatorActiveWidth animated:shouldAnimate];
            break;
    }
    switch (formFieldState) {
        case BZGFormFieldStateNone:
            self.leftIndicator.backgroundColor = self.leftIndicatorNoneColor;
            [self.leftIndicator setTitle:@"" forState:UIControlStateNormal];
            break;
        case BZGFormFieldStateInvalid:
            self.leftIndicator.backgroundColor = self.leftIndicatorInvalidColor;
            [self.leftIndicator setTitle:(leftIndicatorState) ? @"!" : @""
                                forState:UIControlStateNormal];
            break;
        case BZGFormFieldStateValid:
        default:
            self.leftIndicator.backgroundColor = self.leftIndicatorValidColor;
            [self.leftIndicator setTitle:@"" forState:UIControlStateNormal];
            break;
    }
}

- (void)updateLeftIndicatorAspectRatio:(CGFloat)aspectRatio animated:(BOOL)animated
{
    _currentLeftIndicatorAspectRatio = aspectRatio;
    void (^animations)() = ^{
        self.leftIndicator.frame = CGRectMake(self.bounds.origin.x,
                                              self.bounds.origin.y,
                                              self.bounds.size.height*_currentLeftIndicatorAspectRatio,
                                              self.bounds.size.height);

        CGFloat textFieldX = self.bounds.size.height*(_currentLeftIndicatorAspectRatio+self.leftIndicatorRightPadding);
        self.textField.frame = CGRectMake(self.bounds.origin.x + textFieldX,
                                          self.bounds.origin.y,
                                          self.bounds.size.width - textFieldX,
                                          self.bounds.size.height);

    };
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:animations completion:nil];
    } else {
        animations();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateLeftIndicatorAspectRatio:_currentLeftIndicatorAspectRatio animated:NO];
    self.leftIndicator.titleLabel.font = [UIFont systemFontOfSize:
                                          self.textField.font.pointSize*1.5];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)aTextField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:aTextField];
    } else {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField
{
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:aTextField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)aTextField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:aTextField];
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField
{
    if (aTextField.text.length == 0) {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateNone animated:NO];
    } else if (_textValidationBlock(aTextField.text)) {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateValid animated:NO];
    } else {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateActive formFieldState:BZGFormFieldStateInvalid animated:YES];
    }

    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:aTextField];
    }
}

- (BOOL)textField:(UITextField *)aTextField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *newText = [aTextField.text stringByReplacingCharactersInRange:range withString:string];

    if (_textValidationBlock(newText)) {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateValid animated:NO];
    } else {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateInvalid animated:NO];
    }
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:aTextField
          shouldChangeCharactersInRange:range
                      replacementString:string];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)aTextField
{
    [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateNone animated:NO];

    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:aTextField];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:aTextField];
    } else {
        return YES;
    }
}

#pragma mark - UITextField notifications

- (void)textFieldTextDidChange:(NSNotification *)notification
{
    UITextField *aTextField = (UITextField *)notification.object;
    if ([textField isEqual:self.textField] && !aTextField.text.length) {
        [self updateLeftIndicatorState:BZGLeftIndicatorStateInactive formFieldState:BZGFormFieldStateNone animated:NO];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)aAlertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.textField becomeFirstResponder];

    if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [self.delegate alertView:aAlertView willDismissWithButtonIndex:buttonIndex];
    }
}

#pragma mark - Actions

- (void)leftIndicatorTouchDown
{
    UIColor *color = [self.leftIndicator.backgroundColor colorWithAlphaComponent:0.8];
    self.leftIndicator.backgroundColor = color;
}

- (void)leftIndicatorTouchUp
{
    UIColor *color = [self.leftIndicator.backgroundColor colorWithAlphaComponent:1.0];
    self.leftIndicator.backgroundColor = color;

    [self.alertView show];
}




@end
