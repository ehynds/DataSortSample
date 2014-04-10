//
//  CarouselView.h
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselViewDelegate <NSObject>

@required
- (UIView *)viewForCarouselItem:(id)model frame:(CGRect)frame;

@end

@interface BCCCarouselView : UIScrollView

/// An array of the UIViews within the carousel
@property (nonatomic, strong) NSMutableArray *carouselItems;

/// Designated initializer
- (id)initWithFrame:(CGRect)frame
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing;

/// Populate the carousel with an array of models. The carousel will call the delegate method `viewForCarouselItem:model:index` which should return a UIView for the item
- (void)populateWithModels:(NSArray *)models;

@end
