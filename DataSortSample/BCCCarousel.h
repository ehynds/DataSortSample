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
- (UIView *)viewForCarouselItemIndex:(int)index
                               frame:(CGRect)frame
                            carousel:(id)carousel;

@end

@interface BCCCarousel : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) id <CarouselViewDelegate> delegate;

/// Designated initializer
- (id)initWithFrame:(CGRect)frame
           numItems:(int)numItems
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing;

/// Determine whether an item in the carousel is currently within view
- (BOOL)itemIsVisible:(UIView *)itemView;

/// Retrieve an array of items currently within view
- (NSArray *)visibleItems;

@end
