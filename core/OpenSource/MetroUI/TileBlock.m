//
//  TileBlock.m
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//

#import "TileBlock.h"
#import "Tile.h"
#import "TileWall.h" 

@interface TileBlock(){
    NSUInteger _indexInTileWall;
}

- (CGRect) calculateFrame;

@end

@implementation TileBlock 
@synthesize rows;
@synthesize columns;
@synthesize cellWidth;
@synthesize cellHeight;
@synthesize cellSplitWidth;
@synthesize cellSplitHeight;
@synthesize blockLeft;
@synthesize blockTop;
@synthesize blockLeftPadding;
@synthesize blockTopPadding;
@synthesize blockRightPadding;
@synthesize blockBottomPadding;
@synthesize wallLeftPadding;
@synthesize wallTopPadding;
@synthesize tiles;
@synthesize wall;

- (void) dealloc{
    self.tiles = nil;
    self.wall = nil;
    [super dealloc];
}

- (id) init{
    return [self initWithWall:nil withGird:CCGGridMake(gridRowsDefault, gridColumnsDefault) andCellSize:(CGSize) CGSizeMake(cellWidthDefault, cellHeightDefault) andCellSplitSize:CGSizeMake(cellSplitWidthDefault, cellSplitHeightDefault)];
}

- (id) initWithWall:(TileWall *) theWall withGird:(CCGGrid) grid andCellSize:(CGSize) cellSize andCellSplitSize:(CGSize) cellSplitSize{
    return [self initWithWall: theWall withGird:(CCGGrid) grid andCellSize:(CGSize) cellSize andCellSplitSize:(CGSize) cellSplitSize andSelfOrigin:CGPointMake(0, 0) andPadding:CCGPaddingMake(blockLeftPaddingDefault, blockTopPaddingDefault, blockRightPaddingDefault, blockBottomPaddingDefault)];
}

- (id) initWithWall:(TileWall *) theWall withGird:(CCGGrid) grid andCellSize:(CGSize) cellSize andCellSplitSize:(CGSize) cellSplitSize andSelfOrigin:(CGPoint)origin andPadding:(CCGPadding) padding{
    
    self.rows = grid.rows;
    self.columns = grid.columns;
    self.cellWidth = cellSize.width;
    self.cellHeight = cellSize.height;
    self.cellSplitWidth = cellSplitSize.width;
    self.cellSplitHeight = cellSplitSize.height;
    self.blockLeft = origin.x;
    self.blockTop = origin.y;
    self.blockLeftPadding = padding.left;
    self.blockTopPadding = padding.top;
    self.blockRightPadding = padding.right;
    self.blockBottomPadding = padding.bottom;
    self.wall = theWall;
    
    return [self initWithFrame:[self calculateFrame]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code 
        _indexInTileWall = -1;
        self.backgroundColor = [UIColor clearColor];
        tiles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (CGRect) calculateFrame{
    //float _wallLeftPadding = self.wall == nil? wallLeftPaddingDefault:self.wall.wallLeftPadding;
    //float _wallTopPadding = self.wall == nil? wallTopPaddingDefault:self.wall.wallTopPadding;
    float _blockLeftPadding = self.blockLeftPadding == 0? blockLeftPaddingDefault:self.blockLeftPadding;
    float _blockTopPadding = self.blockTopPadding == 0? blockTopPaddingDefault:self.blockTopPadding;
    float _blockRightPadding = self.blockRightPadding == 0? blockRightPaddingDefault:self.blockRightPadding;
    float _blockBottomPadding = self.blockBottomPadding == 0? blockBottomPaddingDefault:self.blockBottomPadding;
    
    return CGRectMake( self.blockLeft, self.blockTop,_blockLeftPadding+cellWidth*self.columns+cellSplitWidth*(self.columns - 1) + _blockRightPadding,_blockTopPadding+cellHeight*self.rows+cellSplitHeight*(self.rows-1) + _blockBottomPadding);
}

//目前支持4*3 矩阵 4行 3列
+ (CGSize) getDefaultSize:(CCGGrid)grid{
    return CGSizeMake(blockLeftPaddingDefault + cellWidthDefault*grid.columns + cellSplitWidthDefault*(grid.columns-1) + blockRightPaddingDefault, blockTopPaddingDefault + cellHeightDefault*grid.rows+cellSplitHeightDefault*(grid.rows-1) + blockBottomPaddingDefault);
}

- (NSUInteger) indexInTileWall {
    return _indexInTileWall;
}

- (void) setIndexInTileWall:(NSUInteger)indexInTileWall{
    _indexInTileWall = indexInTileWall;
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
    if(self.wall != nil){
        self.wallLeftPadding = self.wall.wallLeftPadding;
        self.wallTopPadding = self.wall.wallTopPadding;
    }
    int i=0;
    for(Tile *tile in self.tiles){
        if([tile superview] == nil){
            tile.indexInTileBlock = i;
            [self addSubview:tile]; 
            i++;
        }
        [tile refresh];
    }
    self.frame = [self calculateFrame];
    NSLog(@"block refresh %@", NSStringFromCGRect(self.frame));
}

@end
