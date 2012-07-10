//
//  TileWall.h
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//

#define blockSplitWidthDefault 40
#define wallLeftPaddingDefault 0
#define wallRightPaddingDefault 0
#define wallTopPaddingDefault 0
#define wallBottomPaddingDefault 0

#import <UIKit/UIKit.h>
#import "CCGGeometry.h"
#import "DDPageControl.h"
@class TileBlock;

@protocol TileWallDelegate;


@interface TileWall : UIView<UIScrollViewDelegate,DDPageControlDelegate>


@property (nonatomic,retain) NSMutableArray *tileBlocks;
@property (nonatomic) float wallLeft;
@property (nonatomic) float wallTop;
@property (nonatomic) float blockSplitWidth;
@property (nonatomic) float wallLeftPadding;
@property (nonatomic) float wallTopPadding;
@property (nonatomic) float wallRightPadding;
@property (nonatomic) float wallBottomPadding;
@property (nonatomic, retain) DDPageControl  *pageControl; 
@property (nonatomic, assign) id<TileWallDelegate> tileWallDelegate;
@property (nonatomic) CGPoint contentOffset;
@property (nonatomic, readonly) CGSize scrollSize;

@property (nonatomic, readonly) NSUInteger currentBlockIndex;

- (id) init;

- (id) initWithOrigin:(CGPoint)origin;

- (id) initWithOrigin:(CGPoint)origin andBlockSplitWidth:(float)splitWidth andPadding:(CCGPadding) padding;

- (void) refresh;

@end

@protocol TileWallDelegate<NSObject>

@optional
- (void) tileWall:(TileWall *) tileWall scrollFrom:(TileBlock*)fromTileBlock to:(TileBlock*) toTileBlock;

@end
