//
//  CarouselView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselItemView.h"
#import "CarouselItemModel.h"


@interface CarouselView()

@property (nonatomic, strong) NSMutableArray *carouselItems;

@end

@implementation CarouselView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    
    self.showsHorizontalScrollIndicator = NO;
    
    return self;
}

- (void)populateWithModels:(NSArray *)models
{
    int counter = 0;
    
    for(CarouselItemModel *model in models) {
        float x = counter == 0 ? 0 : ((counter * self.itemWidth) + (self.itemSpacing * counter));
        
        if(self.horizontalEdgeOffset > 0) {
            x += self.horizontalEdgeOffset;
        }
        
        CGRect frame = CGRectMake(x, 0, self.itemWidth, self.bounds.size.height);
        CarouselItemView *carouselItem = [[CarouselItemView alloc] initWithFrame:frame andModel:model];
        
        [self addSubview:carouselItem];
        [self.carouselItems addObject:carouselItem];
        counter++;
    }
    
    float totalWidth = (self.itemWidth * models.count) + (self.itemSpacing * models.count);
    totalWidth -= self.itemSpacing; // make sure the last item is flush with the edge
    totalWidth += self.horizontalEdgeOffset * 2; // account for the horizontal edge offset
    self.contentSize = CGSizeMake(totalWidth, self.bounds.size.height);
}

@end
