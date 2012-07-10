//
//  Tile.h
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "CCGGeometry.h"
typedef enum {
    TileShowModeTextBigIconSmall,
    TileShowModeIconBigTextSmall
}TileShowMode;
@protocol TileDelegate;

@interface Tile : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,readonly) UIView *contentView;
@property (nonatomic,readonly) UILabel *titleLabel;
@property (nonatomic,readonly) UIImageView *iconView;
@property (nonatomic,readonly) UIImageView *backgroundImageView;
@property (nonatomic) NSUInteger indexInTileBlock;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) UIImage *icon;
@property (nonatomic,retain) UIImage *backgroundImage;
@property (nonatomic,retain) UIImage *defaultBackgroundImage;
@property (nonatomic) TileShowMode showMode;

@property (nonatomic) int rowNoLocationFrom;
@property (nonatomic) int columnNoLocationFrom; 
@property (nonatomic) int rowNoLocationTo;
@property (nonatomic) int columnNoLocationTo; 

@property (nonatomic,readonly) int minRowNo;
@property (nonatomic,readonly) int spanRows;
@property (nonatomic,readonly) int minColumnNo;
@property (nonatomic,readonly) int spanColumns;

@property (nonatomic) float blockLeftPadding;
@property (nonatomic) float blockTopPadding;

@property (nonatomic) float cellWidth;
@property (nonatomic) float cellHeight;

@property (nonatomic) float cellSplitWidth;
@property (nonatomic) float cellSplitHeight;
@property (nonatomic,retain) UIColor *normalColor;
@property (nonatomic,retain) UIColor *hightLightColor;

@property (nonatomic, assign) id <TileDelegate> delegate;

- (id) initWithLocation:(CCGGridLocation)location andDefaultBackgroundImage:(UIImage*) theDefaultBackgroundImage;

- (id) initWithFromLocation:(CCGGridLocation)fromLocation ToLocation:(CCGGridLocation)toLocation andDefaultBackgroundImage:(UIImage*) theDefaultBackgroundImage;

- (void) refresh;

- (void) restore;

@end

@protocol TileDelegate<NSObject>

@optional
- (void) tileTapped:(Tile *) tile;
@end
