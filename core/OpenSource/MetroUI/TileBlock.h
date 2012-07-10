//
//  TileBlock.h
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//
#define gridRowsDefault 4
#define gridColumnsDefault 3
#define cellWidthDefault 84
#define cellHeightDefault 84
#define cellSplitWidthDefault 7
#define cellSplitHeightDefault 7
#define blockLeftPaddingDefault 0
#define blockRightPaddingDefault 0
#define blockTopPaddingDefault 0
#define blockBottomPaddingDefault 0


#import <UIKit/UIKit.h>
#import "CCGGeometry.h"

@class TileWall;

@interface TileBlock : UIView

@property (nonatomic) int rows;
@property (nonatomic) int columns;
@property (nonatomic) NSUInteger indexInTileWall;
@property (nonatomic) float cellWidth;
@property (nonatomic) float cellHeight;
@property (nonatomic) float cellSplitWidth;
@property (nonatomic) float cellSplitHeight;
@property (nonatomic) float blockLeft;
@property (nonatomic) float blockTop;
@property (nonatomic) float blockLeftPadding;
@property (nonatomic) float blockTopPadding;
@property (nonatomic) float blockRightPadding;
@property (nonatomic) float blockBottomPadding;
@property (nonatomic) float wallLeftPadding;
@property (nonatomic) float wallTopPadding;
@property (nonatomic, assign) TileWall *wall;

@property (nonatomic,retain) NSMutableArray *tiles;



- (id) init;

- (id) initWithWall:(TileWall *) theWall withGird:(CCGGrid) grid andCellSize:(CGSize) cellSize andCellSplitSize:(CGSize) cellSplitSize;

- (id) initWithWall:(TileWall *) theWall withGird:(CCGGrid) grid andCellSize:(CGSize) cellSize andCellSplitSize:(CGSize) cellSplitSize andSelfOrigin:(CGPoint)origin andPadding:(CCGPadding) padding;

+ (CGSize) getDefaultSize:(CCGGrid)grid; 

- (void) refresh;

@end
