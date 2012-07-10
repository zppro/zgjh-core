//
//  CCGGeometry.h
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-9-24.
//  Copyright 2011年 codans. All rights reserved.
//

#ifndef CodansShareLibrary10_CCGGeometry_h
#define CodansShareLibrary10_CCGGeometry_h

struct CCGPadding {
    CGFloat left;
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
};
typedef struct CCGPadding CCGPadding;

CG_INLINE CCGPadding 
CCGPaddingMake(CGFloat left, CGFloat top,CGFloat right, CGFloat bottom)
{
    CCGPadding padding; 
    padding.left = left; 
    padding.top = top;
    padding.right = right; 
    padding.bottom = bottom; 
    return padding;
}

struct CCGGrid {
    integer_t rows;
    integer_t columns;
};
typedef struct CCGGrid CCGGrid;

CG_INLINE CCGGrid 
CCGGridMake(integer_t rows, integer_t columns)
{
    CCGGrid grid; 
    grid.rows = rows; 
    grid.columns = columns; 
    return grid;
}

struct CCGGridLocation {
    integer_t rowNo;
    integer_t columnNo;
};
typedef struct CCGGridLocation CCGGridLocation;

CG_INLINE CCGGridLocation 
CCGGridLocationMake(integer_t rowNo, integer_t columnNo)
{
    CCGGridLocation location; 
    location.rowNo = rowNo; 
    location.columnNo = columnNo; 
    return location;
}
 

#endif
