//
//  CarouselView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "BCCCarousel.h"

@interface BCCCarousel()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) int itemWidth;
@property (nonatomic, assign) int itemSpacing;
@property (nonatomic, assign) int edgeSpacing;

@end

@implementation BCCCarousel

- (id)initWithFrame:(CGRect)frame
          andModels:(NSArray *)models
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing
{
    if(self = [super init]) {
        _models = models;
        _itemWidth = itemWidth;
        _itemSpacing = itemSpacing;
        _edgeSpacing = edgeSpacing;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.layer.borderColor = [UIColor blackColor].CGColor;
        _scrollView.layer.borderWidth = 2.0f;
        
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // If the UIScrollView is added to the view hierarchy before this time then
    // its contentSize is calculated correctly when using an autoResizingMask.
    [self.view addSubview:self.scrollView];
    
    [self populate];
}

- (void)populate
{
    int counter = 0;
    int height = self.scrollView.bounds.size.height;
    
    for(id model in self.models) {
        float x = counter == 0 ? 0 : ((counter * self.itemWidth) + (self.itemSpacing * counter));
        
        if(self.edgeSpacing > 0) {
            x += self.edgeSpacing;
        }
        
        CGRect itemRect = CGRectMake(x, 0, self.itemWidth, height);
        UIView *carouselItem = [[self delegate] viewForCarouselItem:model frame:itemRect];
        [self.scrollView addSubview:carouselItem];
        [self.carouselItems addObject:carouselItem];
        
        counter++;
    }
    
    float totalWidth = (self.itemWidth * self.models.count) + (self.itemSpacing * self.models.count);
    totalWidth -= self.itemSpacing; // make sure the last item is flush with the edge
    totalWidth += self.edgeSpacing * 2; // account for the horizontal edge offset
    self.scrollView.contentSize = CGSizeMake(totalWidth, height);
}

@end
