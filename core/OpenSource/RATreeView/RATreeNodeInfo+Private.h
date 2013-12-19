//
//  RATreeNodeInfo+Private.h
//  RATreeView
//
//  Created by Rafal Augustyniak on 07.09.2013.
//  Copyright (c) 2013 Rafal Augustyniak. All rights reserved.
//

#import "RATreeNodeInfo.h"
@class RATreeNode;

@interface RATreeNodeInfo (Private)

@property (nonatomic, getter = isExpanded, readwrite) BOOL expanded;
@property (nonatomic, readwrite) NSInteger treeDepthLevel;

@property (nonatomic, readwrite) NSInteger siblingsNumber;
@property (nonatomic, readwrite) NSInteger positionInSiblings;

@property (retain, nonatomic, readwrite) RATreeNode *parentTreeNode;
@property (retain, nonatomic, readwrite) NSArray * childrenTreeNodes;

@property (retain, nonatomic, readwrite) id item;

- (id)initWithParent:(RATreeNode *)parent children:(NSArray *)children;

@end
