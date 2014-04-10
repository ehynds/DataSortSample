//
//  CarouselView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "BCCCarousel.h"

@interface BCCCarousel()

@property (nonatomic, assign) int itemWidth;
@property (nonatomic, assign) int itemSpacing;
@property (nonatomic, assign) int edgeSpacing;

@end

@implementation BCCCarousel

- (id)initWithFrame:(CGRect)frame
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing
{
    if(self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        
        _itemWidth = itemWidth;
        _itemSpacing = itemSpacing;
        _edgeSpacing = edgeSpacing;
    }
    
    return self;
}

- (void)populateWithModels:(NSArray *)models
{
    int counter = 0;
    int height = self.bounds.size.height;
    
    for(id model in models) {
        float x = counter == 0 ? 0 : ((counter * self.itemWidth) + (self.itemSpacing * counter));
        
        if(self.edgeSpacing > 0) {
            x += self.edgeSpacing;
        }
        
        CGRect itemRect = CGRectMake(x, 0, self.itemWidth, height);
        UIView *carouselItem = [[self delegate] viewForCarouselItem:model frame:itemRect];
        [self addSubview:carouselItem];
        [self.carouselItems addObject:carouselItem];
        
        counter++;
    }
    
    float totalWidth = (self.itemWidth * models.count) + (self.itemSpacing * models.count);
    totalWidth -= self.itemSpacing; // make sure the last item is flush with the edge
    totalWidth += self.edgeSpacing * 2; // account for the horizontal edge offset
    
    self.contentSize = CGSizeMake(totalWidth, height);
}

@end
