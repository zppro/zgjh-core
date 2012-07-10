//
//  Tile.m
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//
#define contentViewPaddingLeftRight 5
#define contentViewPaddingTopBottom 5

#import "Tile.h"
#import "TileBlock.h"
#import "UIView+Motion.h"
#import "UIImage+Scale.h"

@interface Tile() {
    NSUInteger _indexInTileBlock;
}
 
- (CGRect) calculateFrame;

@end

@implementation Tile
@synthesize contentView;
@synthesize titleLabel;
@synthesize iconView;
@synthesize backgroundImageView;
@synthesize defaultBackgroundImage;
@synthesize title;
@synthesize icon; 
@synthesize showMode; 
@synthesize rowNoLocationFrom;
@synthesize columnNoLocationFrom;
@synthesize rowNoLocationTo;
@synthesize columnNoLocationTo;
@synthesize minRowNo;
@synthesize spanRows;
@synthesize minColumnNo;
@synthesize spanColumns;
@synthesize blockLeftPadding;
@synthesize blockTopPadding;
@synthesize cellWidth;
@synthesize cellHeight;
@synthesize cellSplitWidth;
@synthesize cellSplitHeight;
@synthesize normalColor;
@synthesize hightLightColor;
@synthesize delegate;


- (void) dealloc{
    [contentView release];
    [titleLabel release];
    [iconView release];
    [backgroundImageView release];
    self.title = nil;
    self.icon = nil;  
    self.normalColor = nil;
    self.hightLightColor = nil;
    //  self.defaultBackgroundImage = nil;
    [super dealloc];
}
 
- (id) initWithLocation:(CCGGridLocation)location andDefaultBackgroundImage:(UIImage*) theDefaultBackgroundImage {
    return [self initWithFromLocation:location ToLocation:location andDefaultBackgroundImage:theDefaultBackgroundImage];
}

- (id) initWithFromLocation:(CCGGridLocation)fromLocation ToLocation:(CCGGridLocation)toLocation andDefaultBackgroundImage:(UIImage*) theDefaultBackgroundImage {
    
    self.rowNoLocationFrom = fromLocation.rowNo;
    self.columnNoLocationFrom = fromLocation.columnNo;
    self.rowNoLocationTo = toLocation.rowNo;
    self.columnNoLocationTo = toLocation.columnNo;
    minRowNo = MIN(self.rowNoLocationFrom, self.rowNoLocationTo);
    spanRows = ABS(self.rowNoLocationTo - self.rowNoLocationFrom);
    minColumnNo = MIN(self.columnNoLocationFrom, self.columnNoLocationTo);
    spanColumns = ABS(self.columnNoLocationTo - self.columnNoLocationFrom);
    return [self initWithFrame:[self calculateFrame] andDefaultBackgroundImage:theDefaultBackgroundImage];
    
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andDefaultBackgroundImage:nil];
}
- (id)initWithFrame:(CGRect)frame andDefaultBackgroundImage:(UIImage*) theDefaultBackgroundImage {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.defaultBackgroundImage = theDefaultBackgroundImage;
        self.backgroundColor = [UIColor whiteColor];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(contentViewPaddingLeftRight, contentViewPaddingTopBottom, self.bounds.size.width - contentViewPaddingLeftRight*2,self.bounds.size.height - contentViewPaddingTopBottom*2)]; 
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:contentView];

        
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [contentView addSubview:backgroundImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:contentView.frame];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16];//[UIFont fontWithName:@"Helvetica-Bold" size:16]
        [contentView addSubview:titleLabel];
        //contentView.backgroundColor =[UIColor redColor];
        
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,contentView.bounds.size.height - 16,16,16)];
        iconView.hidden = YES;
        [contentView addSubview:iconView];
        
         
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTile:)];
        [contentView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
    }
    return self;
}

- (CGRect) calculateFrame{
    
    float _blockLeftPadding = [self superview] == nil? blockLeftPaddingDefault:self.blockLeftPadding;
    float _blockTopPadding = [self superview] == nil? blockTopPaddingDefault:self.blockTopPadding;
    float _cellWidth = [self superview] == nil? cellWidthDefault:self.cellWidth;
    float _cellHeight = [self superview] == nil? cellHeightDefault:self.cellHeight;
    float _cellSplitWidth = [self superview] == nil? cellSplitWidthDefault:self.cellSplitWidth;
    float _cellSplitHeight = [self superview] == nil? cellSplitHeightDefault:self.cellSplitHeight;
    float x = _blockLeftPadding + (minColumnNo - 1) * (_cellWidth + _cellSplitWidth);
    float y = _blockTopPadding + (minRowNo - 1) * (_cellHeight + _cellSplitHeight);
    float width = _cellWidth * (spanColumns+1) + _cellSplitWidth * spanColumns;
    float height = _cellHeight * (spanRows+1) + _cellSplitHeight * spanRows;
    
    return CGRectMake(x, y, width, height);
}

- (NSUInteger) indexInTileBlock {
    return _indexInTileBlock;
}

- (void) setIndexInTileBlock:(NSUInteger)indexInTileBlock {
    _indexInTileBlock = indexInTileBlock;
}

- (UIImage *)backgroundImage {
    return backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)newBackgroundImage {
    if(newBackgroundImage != nil){ 
        backgroundImageView.frame = CGRectMake(0,0,contentView.bounds.size.width,contentView.bounds.size.height);
        
        //backgroundImageView.image = [newBackgroundImage scaleToSize:self.bounds.size];
        [NSThread detachNewThreadSelector:@selector(loadBackgroundImageInThread:) toTarget:self withObject:newBackgroundImage];
    }
    else{
        backgroundImageView.image = defaultBackgroundImage; 
    } 
}

- (void)loadBackgroundImageInThread:(UIImage*) image {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    backgroundImageView.image = [image scaleToSize:self.bounds.size];
    [pool release];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) refresh{
    if([self superview] != nil){
        self.blockLeftPadding = ((TileBlock*)[self superview]).blockLeftPadding;
        self.blockTopPadding = ((TileBlock*)[self superview]).blockTopPadding;
        self.cellWidth = ((TileBlock*)[self superview]).cellWidth;
        self.cellHeight = ((TileBlock*)[self superview]).cellHeight;
        self.cellSplitWidth = ((TileBlock*)[self superview]).cellSplitWidth;
        self.cellSplitHeight = ((TileBlock*)[self superview]).cellSplitHeight;
    }
    
    self.frame = [self calculateFrame]; 
    contentView.frame = CGRectMake(contentViewPaddingLeftRight, contentViewPaddingTopBottom, self.bounds.size.width - contentViewPaddingLeftRight*2,self.bounds.size.height - contentViewPaddingTopBottom*2);
    if(self.backgroundImageView.image == nil){
        [self setBackgroundImage:defaultBackgroundImage];
    }
    float iconWidth = 0;
    float iconHeight = 0;
    if (icon!=nil) {
        iconView.image = icon;
        //iconView.bounds = CGRectMake(0, 0, icon.size.width/2, icon.size.height/2);
        iconView.hidden = NO;
        if(showMode == TileShowModeTextBigIconSmall){
            if(icon.size.width > icon.size.height){
                iconWidth = 16;
                iconHeight = 16*icon.size.height / icon.size.width;
            }
            else if (icon.size.width < icon.size.height){
                iconHeight = 16;
                iconWidth = 16*icon.size.width / icon.size.height;
            }
            else{
                iconWidth = 16;
                iconHeight = 16;
            }
        }
        else if(showMode == TileShowModeIconBigTextSmall)
        {
            if(icon.size.width > icon.size.height){
                iconWidth = 48;
                iconHeight = 48*icon.size.height / icon.size.width;
            }
            else if(icon.size.width < icon.size.height){
                iconHeight = 48;
                iconWidth = 48*icon.size.width / icon.size.height;
            }
            else{
                iconWidth = 48;
                iconHeight = 48;
            }
        }
    }
    else{
        iconView.image = nil;
        iconView.hidden = YES;
    }
    
    if(showMode == TileShowModeTextBigIconSmall){
        [contentView bringSubviewToFront:titleLabel];
        [contentView sendSubviewToBack:iconView];
        titleLabel.frame = contentView.bounds;
        
        iconView.frame = CGRectMake(0,contentView.bounds.size.height - iconHeight,iconWidth,iconHeight);
        titleLabel.textAlignment = UITextAlignmentCenter;
    }
    else if(showMode == TileShowModeIconBigTextSmall){
        [contentView bringSubviewToFront:iconView];
        [contentView sendSubviewToBack:titleLabel];
        CGRect iconFrame;
        CGRect titleFrame;
        if(spanColumns>spanRows){
            //列数大于行数
            CGSize textSize = [titleLabel.text sizeWithFont:titleLabel.font];
            iconFrame = CGRectMake(contentView.bounds.size.width /2 - (textSize.width+iconWidth)/2,(contentView.bounds.size.height - iconHeight)/2 ,iconWidth,iconHeight);
            
            titleFrame = CGRectMake(iconFrame.origin.x + iconWidth + contentViewPaddingLeftRight ,0,contentView.bounds.size.width - iconWidth - contentViewPaddingLeftRight ,contentView.bounds.size.height);
            titleLabel.textAlignment = UITextAlignmentLeft;
        }
        else if(spanColumns < spanRows){
            //行数大于列数
            iconFrame = CGRectMake((contentView.bounds.size.width - iconWidth)/2,0 ,iconWidth,iconHeight);
            titleFrame = CGRectMake(0,iconHeight + contentViewPaddingTopBottom,contentView.bounds.size.width,contentView.bounds.size.height - iconHeight - contentViewPaddingTopBottom);
            titleLabel.textAlignment = UITextAlignmentLeft;
        }
        else{
            //行与列相等
            iconFrame = CGRectMake((contentView.bounds.size.width-(iconWidth))/2,contentView.bounds.size.height - 16 - iconHeight,iconWidth,iconHeight);
            titleFrame = CGRectMake(0,contentView.bounds.size.height - 20,contentView.bounds.size.width,20);
            titleLabel.textAlignment = UITextAlignmentCenter;
        } 
        iconView.frame = iconFrame;
        titleLabel.frame = titleFrame;
    }  
    if(normalColor != nil){
        self.backgroundColor = normalColor;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor blackColor];
    }
}

- (void)restore {
    if(defaultBackgroundImage != nil){ 
        //backgroundImageView.image = [defaultBackgroundImage scaleToSize:self.bounds.size];
        [NSThread detachNewThreadSelector:@selector(loadBackgroundImageInThread:) toTarget:self withObject:defaultBackgroundImage];
    }
}

#pragma mark 行为

- (void)tapTile:(UIGestureRecognizer *)gestureRecognizer {
    [self scaleMe2D];
    [UIView animateWithDuration:0.07 animations:^{
        self.backgroundColor = self.hightLightColor;
    }completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.00 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.backgroundColor = self.normalColor;
            } completion:NULL];
        }
    }]; 
    gestureRecognizer.cancelsTouchesInView = NO;
    if(delegate != nil){
        if([delegate respondsToSelector:@selector(tileTapped:)]){ 
            [delegate tileTapped:self];
        }
    }
}


@end
