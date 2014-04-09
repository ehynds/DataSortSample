//
//  CarouselView.h
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIScrollView

/// The amount of spacing between the carousel edge and the first/last items
@property (nonatomic, assign) int horizontalEdgeOffset;

/// Width of each carousel item
@property (nonatomic, assign) int itemWidth;

/// Amount of spacing in between carousel items
@property (nonatomic, assign) int itemSpacing;

/// Populate the carousel with an array of models
- (void)populate:(NSArray *)models;

@end
