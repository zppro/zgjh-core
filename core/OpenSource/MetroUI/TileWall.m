//
//  TileWall.m
//  AirMenu120
//
//  Created by 钟 平 on 11-9-23.
//  Copyright 2011年 Codans. All rights reserved.
//

#import "TileWall.h"
#import "TileBlock.h"
#import "Tile.h"
#import "UIView+Size.h"
#import "MacroFunctions.h"

@interface TileWall(){
    BOOL pageControlUsed;
}

- (CGRect) calculateFrame;

- (CGSize) calculateContentSize;

@property (nonatomic, retain) UIScrollView * tileBlocksContainer;

@end

@implementation TileWall
@synthesize wallLeft;
@synthesize wallTop;
@synthesize blockSplitWidth;
@synthesize wallLeftPadding;
@synthesize wallTopPadding;
@synthesize wallRightPadding;
@synthesize wallBottomPadding;
@synthesize tileBlocks;
@synthesize pageControl;
@synthesize tileWallDelegate;
@synthesize tileBlocksContainer;

- (void) dealloc{ 
    self.tileBlocks = nil;
    self.pageControl = nil;
    self.tileBlocksContainer = nil;
    [super dealloc];
}

- (id) init{
    return [self initWithOrigin:CGPointMake(0, 0)];
}

- (id) initWithOrigin:(CGPoint)origin{
    return [self initWithOrigin:origin andBlockSplitWidth:blockSplitWidthDefault andPadding:CCGPaddingMake(wallLeftPaddingDefault, wallTopPaddingDefault, wallRightPaddingDefault, wallBottomPaddingDefault)];
}

- (id) initWithOrigin:(CGPoint)origin andBlockSplitWidth:(float)splitWidth andPadding:(CCGPadding) padding{
    self.wallLeft = origin.x;
    self.wallTop = origin.y;
    self.blockSplitWidth = splitWidth;
    self.wallLeftPadding = padding.left;
    self.wallTopPadding = padding.top;
    self.wallRightPadding = padding.right;
    self.wallBottomPadding = padding.bottom;
    
    return [self initWithFrame:[self calculateFrame]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
      
        tileBlocks = [[NSMutableArray alloc] init];
        /*
        self.delegate = self;
        self.pagingEnabled = YES; 
        self.scrollsToTop = NO;
         */
        self.tileBlocksContainer = makeScrollView(0.0f, 0.0f, self.width, self.height - 44.f);
        tileBlocksContainer.backgroundColor = [UIColor clearColor]; 
        tileBlocksContainer.showsVerticalScrollIndicator = false;
        tileBlocksContainer.showsHorizontalScrollIndicator = false;
        tileBlocksContainer.pagingEnabled = YES;
        tileBlocksContainer.delegate = self; 
        tileBlocksContainer.scrollsToTop = NO;
        //tileBlocksContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:tileBlocksContainer];
        
        self.pageControl = [[[DDPageControl alloc] init] autorelease];
        [pageControl addTarget:self action:@selector(pageTo:) forControlEvents:UIControlEventValueChanged];
        [pageControl setOnColor: [UIColor colorWithWhite: 0.7f alpha: 1.0f]] ;
        [pageControl setOffColor: [UIColor colorWithWhite: 0.9f alpha: 1.0f]] ;
        pageControl.delegate = self;
        [self addSubview:pageControl]; 
    }
    return self;
}

- (CGRect) calculateFrame{ 
    float _wallLeftPadding = self.wallLeftPadding == 0? wallLeftPaddingDefault:self.wallLeftPadding;
    float _wallTopPadding = self.wallTopPadding == 0? wallTopPaddingDefault:self.wallTopPadding;
    //float _wallRightPadding = self.wallRightPadding == 0? wallRightPaddingDefault:self.wallRightPadding;
    //float _wallBottomPadding = self.wallBottomPadding == 0? wallBottomPaddingDefault:self.wallBottomPadding;
    
    CGSize defaultTileBlockSize = [TileBlock getDefaultSize:CCGGridMake(gridRowsDefault, gridColumnsDefault)];
    float _tileBlockWidth = defaultTileBlockSize.width;
    float _tileBlockHeight = defaultTileBlockSize.height;
    if ([tileBlocks count]>0) {
        _tileBlockWidth = ((TileBlock*)[tileBlocks objectAtIndex:0]).width;
        _tileBlockHeight = ((TileBlock*)[tileBlocks objectAtIndex:0]).height;
    }
    
    return CGRectMake(blockSplitWidth/2.f + _wallLeftPadding, _wallTopPadding,_tileBlockWidth,_tileBlockHeight);
}

- (CGSize) calculateContentSize{ 
    if([self.tileBlocks count]>0){
        TileBlock *tileBlock = [self.tileBlocks objectAtIndex:0]; 
        float tileBlocksWidth = [tileBlocks count] * tileBlock.size.width; 
        return CGSizeMake(tileBlocksWidth, self.tileBlocksContainer.height);
    }
    else{
        return self.tileBlocksContainer.bounds.size;
    } 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Draw a circle 
	// Get the contextRef
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
	// Set the border width
	CGContextSetLineWidth(contextRef, 1.0);
	
	// Set the circle fill color to GREEN
	CGContextSetRGBFillColor(contextRef, 0.0, 255.0, 0.0, 1.0);
	
	// Set the cicle border color to BLUE
	CGContextSetRGBStrokeColor(contextRef, 0.0, 0.0, 255.0, 1.0);
	
	// Fill the circle with the fill color
	CGContextFillEllipseInRect(contextRef, rect);
	
	// Draw the circle border
	CGContextStrokeEllipseInRect(contextRef, rect);
}
*/
- (void) refresh{
    int i=0;
    for(TileBlock *tileBlock in self.tileBlocks){
        if([tileBlock superview] == nil){
            tileBlock.indexInTileWall = i;
            [self.tileBlocksContainer addSubview:tileBlock]; 
            tileBlock.blockLeft = i*tileBlock.bounds.size.width + self.blockSplitWidth * (i==0?0:i-1);
            i++;
        }
        [tileBlock refresh];
    }
    tileBlocksContainer.backgroundColor = [UIColor clearColor];
    tileBlocksContainer.frame = [self calculateFrame];
    tileBlocksContainer.contentSize = [self calculateContentSize];
    tileBlocksContainer.showsVerticalScrollIndicator = NO;
    tileBlocksContainer.showsHorizontalScrollIndicator = NO;  
    float _wallLeftPadding = self.wallLeftPadding == 0? wallLeftPaddingDefault:self.wallLeftPadding;
    float _wallTopPadding = self.wallTopPadding == 0? wallTopPaddingDefault:self.wallTopPadding;
    float _wallRightPadding = self.wallRightPadding == 0? wallRightPaddingDefault:self.wallRightPadding;
    float _wallBottomPadding = self.wallBottomPadding == 0? wallBottomPaddingDefault:self.wallBottomPadding;
    self.frame = CGRectMake(wallLeft, wallTop, tileBlocksContainer.width + blockSplitWidth + _wallLeftPadding +_wallRightPadding, tileBlocksContainer.height + 44.f + _wallTopPadding + _wallBottomPadding);
     
    int numberPerScreen = 1;
    if([self.tileBlocks count] % numberPerScreen == 0){
        pageControl.numberOfPages = [self.tileBlocks count]/numberPerScreen;
    }
    else{
        pageControl.numberOfPages = [self.tileBlocks count]/numberPerScreen + 1;
    } 
    
    pageControl.frame = CGRectMake((self.width*(pageControl.currentPage)) + (self.bounds.size.width - pageControl.numberOfPages * 18)/2.0 - 50.f, self.height - 88 / 2.0, pageControl.numberOfPages* numberPerScreen * 18 , 24);
    if(pageControl.numberOfPages > 1){
        pageControl.hidden = NO;
    }
    else{
        pageControl.hidden = YES;
    }
    [pageControl setCurrentPage:0];
     
}

- (CGPoint) contentOffset {
    return self.tileBlocksContainer.contentOffset;
}

- (void) setContentOffset:(CGPoint)contentOffset {
    self.tileBlocksContainer.contentOffset = contentOffset;
}

- (CGSize) scrollSize {
    return self.tileBlocksContainer.bounds.size;
}

- (void) pageTo:(id) sender{ 
    
    self.tileBlocksContainer.contentOffset = CGPointMake(((TileBlock *)[self.tileBlocks objectAtIndex:pageControl.currentPage]).blockLeft, 0.0f);
    pageControlUsed = YES;
}

- (NSUInteger) currentBlockIndex {
    return pageControl.currentPage;
}
  
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; 
{  
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    } 
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1; 
    pageControl.currentPage = page;  
    
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;  
}

#pragma mark -DDPageControlDelegate
- (void)dDPageControl:(DDPageControl*)theDDPageControl currentPageChangedFrom:(NSUInteger)oldPage to:(NSUInteger)newPage{ 
    if(tileWallDelegate != nil && [tileWallDelegate respondsToSelector:@selector(tileWall:scrollFrom:to:)]){
        [tileWallDelegate tileWall:self scrollFrom:[tileBlocks objectAtIndex:oldPage] to:[tileBlocks objectAtIndex:newPage]];
    }   
}


@end
