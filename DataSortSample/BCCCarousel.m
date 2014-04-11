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
@property (nonatomic, assign) int numItems;
@property (nonatomic, assign) int itemWidth;
@property (nonatomic, assign) int itemSpacing;
@property (nonatomic, assign) int edgeSpacing;

@end

@implementation BCCCarousel

- (id)initWithFrame:(CGRect)frame
           numItems:(int)numItems
          itemWidth:(int)itemWidth
        itemSpacing:(int)itemSpacing
        edgeSpacing:(int)edgeSpacing
{
    if(self = [super init]) {
        _numItems =  numItems;
        _itemWidth = itemWidth;
        _itemSpacing = itemSpacing;
        _edgeSpacing = edgeSpacing;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _scrollView.showsHorizontalScrollIndicator = NO;
        // _scrollView.layer.borderColor = [UIColor blackColor].CGColor;
        // _scrollView.layer.borderWidth = 2.0f;
        _scrollView.delegate = self;
        
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // If the UIScrollView is added to the view hierarchy before this time then
    // its contentSize is calculated incorrectly when using an autoResizingMask.
    [self.view addSubview:self.scrollView];
    
    // Fill the carousel with items
    [self populate];
}

- (void)populate
{
    int height = self.scrollView.bounds.size.height;
    
    for(int i = 0; i < self.numItems; i++) {
        float x = i == 0 ? 0 : ((i * self.itemWidth) + (self.itemSpacing * i));
        
        if(self.edgeSpacing > 0) {
            x += self.edgeSpacing;
        }
        
        CGRect itemRect = CGRectMake(x, 0, self.itemWidth, height);
        UIView *carouselItem = [[self delegate] viewForCarouselItemIndex:i frame:itemRect carousel:self];
        [self.scrollView addSubview:carouselItem];
    }
    
    float totalWidth = (self.itemWidth * self.numItems) + (self.itemSpacing * self.numItems);
    totalWidth -= self.itemSpacing; // make sure the last item is flush with the edge
    totalWidth += self.edgeSpacing * 2; // account for the horizontal edge offset
    self.scrollView.contentSize = CGSizeMake(totalWidth, height);
}

#pragma mark - UIScrollView delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // TODO - lazy load images in [self visibleItems]
}

#pragma mark - Utils

- (BOOL)itemIsVisible:(UIView *)itemView
{
    return CGRectIntersectsRect(self.scrollView.bounds, itemView.frame);
}

- (NSArray *)visibleItems
{
    NSMutableArray *visibleItems = [NSMutableArray array];
    
    for(UIView *view in self.scrollView.subviews) {
        if([self itemIsVisible:view]) {
            [visibleItems addObject:view];
        }
    }
    
    return visibleItems;
}

@end
