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
    
    // Set the correct content width for the number of items we have
    [self setDimensions];
    
    // Load in the items that are visible
    [self loadVisibleItems];
}

- (void)setDimensions
{
    int height = self.scrollView.bounds.size.height;
    float totalWidth = (self.itemWidth * self.numItems) + (self.itemSpacing * self.numItems);
    totalWidth -= self.itemSpacing; // make sure the last item is flush with the edge
    totalWidth += self.edgeSpacing * 2; // account for the horizontal edge offset on either side
    self.scrollView.contentSize = CGSizeMake(totalWidth, height);
}

#pragma mark - UIScrollView delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadVisibleItems];
}

- (void)loadVisibleItems
{
    // int currentPage = (self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    float totalPages = (self.scrollView.contentSize.width / self.scrollView.frame.size.width) - 1;
    float itemsPerPage = self.numItems / (totalPages + 1);
    int firstVisibleItemIndex = self.scrollView.contentOffset.x / (self.scrollView.frame.size.width / itemsPerPage);
    
    // The index of the last item that needs to be loaded
    int endIndex = firstVisibleItemIndex + itemsPerPage + 2;
    endIndex += 2; // +2 so the user doesn't see them items load when they come into view
    endIndex = endIndex > self.numItems ? endIndex = self.numItems : endIndex; // keep in bounds
    
    for(int i = 0; i < self.numItems; i++) {
        UIView *itemView = [self.scrollView viewWithTag:i + 1];
        BOOL isVisibleItem = (i >= firstVisibleItemIndex && i <= endIndex);
        
        // If the current index falls within the range of items that are visible
        // and the view does not exist, load it.
        if(itemView == nil && isVisibleItem) {
            int x = (i * self.itemWidth) + (i * self.itemSpacing);
            x += self.edgeSpacing ? self.edgeSpacing : 0;
            
            CGRect itemRect = CGRectMake(x, 0, self.itemWidth, self.scrollView.frame.size.height);
            UIView *carouselItem = [[self delegate] viewForCarouselItemIndex:i frame:itemRect carousel:self];
            carouselItem.tag = i + 1;
            [self.scrollView addSubview:carouselItem];
            
        // Otherwise if the view is out of sight unload it to reclaim memory
        } else if(itemView && !isVisibleItem) {
            [itemView removeFromSuperview];
        }
    }
    
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
