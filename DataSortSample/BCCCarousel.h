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

@interface BCCCarousel : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) id <CarouselViewDelegate> delegate;

/// An array of the UIViews within the carousel
@property (nonatomic, strong) NSMutableArray *carouselItems;

/// Designated initializer
- (id)initWithFrame:(CGRect)frame
          andModels:(NSArray *)models
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing;

@end
