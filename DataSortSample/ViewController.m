//
//  ViewController.m
//  DataSortSample
//
//  Created by Matthew Propst on 4/4/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BCCCarousel.h"
#import "CarouselItemView.h"
#import "ViewController.h"


#define kIndexViewWidth 30
#define kCellWidth 156
#define kCellHeight 222
#define kCellHorizontalSpacing 22
#define kCellHeaderHeight 35

@interface ViewController ()

@property(nonatomic, strong) NSMutableDictionary *videoDict;
@property(nonatomic, strong) NSMutableDictionary *carousels;
@property(nonatomic, strong) NSArray *letters;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.videos = @[
                    @{ @"title": @"A Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 2", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 3 with a longer title that is really long", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 4", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 5", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 6", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 7", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"A Test 8", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 2", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 3", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 4", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 5", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"B Test 6", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"C Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"C Test 2", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"C Test 3", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"D Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"E Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"F Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" },
                    @{ @"title": @"G Test 1", @"publishedDate": @"Jan. 1, 2014", @"thumbnailURL": @"" }
                     ];
    
    self.videoDict = [self groupByAlpha];
    self.letters = [[self.videoDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Carousel delegate methods

- (UIView *)viewForCarouselItemIndex:(int)index frame:(CGRect)frame carousel:(id)carousel
{
    NSDictionary *video = [[self videosForCarousel:carousel] objectAtIndex:index];
    return [[CarouselItemView alloc] initWithFrame:frame andVideo:video];
}

#pragma mark - Utility functions

// Returns the models that should be associated with a given carousel instance
- (NSArray *)videosForCarousel:(BCCCarousel *)carousel
{
    for(NSString *letter in self.carousels) {
        if([self.carousels objectForKey:letter] == carousel) {
            return [self.videoDict objectForKey:letter];
        }
    }
    
    return @[];
}

// Creates a carousel for a given letter if it hasn't already been created yet.
- (BCCCarousel *)carouselForLetter:(NSString *)letter
{
    if(!self.carousels) {
        self.carousels = [NSMutableDictionary dictionary];
    }
    
    BCCCarousel *carousel;
    
    if((carousel = [self.carousels objectForKey:letter])) {
        return carousel;
    }
    
    CGRect frame = CGRectMake(0, 0, self.tableView.bounds.size.width, kCellHeight);
    
    carousel = [[BCCCarousel alloc] initWithFrame:frame
                                         numItems:[[self.videoDict objectForKey:letter] count]
                                        itemWidth:kCellWidth
                                      itemSpacing:kCellHorizontalSpacing
                                      edgeSpacing:kIndexViewWidth];
    
    carousel.delegate = self;
    self.carousels[letter] = carousel;
    
    return carousel;
}

// Creates a dictionary from the recipes where the key is the letter and the
// value is an array of models
- (NSMutableDictionary *)groupByAlpha
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for(NSDictionary *video in self.videos) {
        NSString *dictKey = [[NSString stringWithFormat:@"%c", [[video objectForKey:@"title"] characterAtIndex:0]] lowercaseString];
        
        if([ret objectForKey:dictKey] == nil) {
            [ret setObject:[NSMutableArray array] forKey:dictKey];
        }
        
        [[ret objectForKey:dictKey] addObject:video];
    }
    
    return ret;
}

// Returns the letter at a specific index (0 = a, 1 = b, and so on)
- (NSString *)letterAtIndex:(NSInteger)index
{
    return [self.letters objectAtIndex:index];
}

#pragma mark - UITableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.letters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *letter = [self letterAtIndex:indexPath.section];
    NSString *reusableCellIdentifier = [NSString stringWithFormat:@"RecipeTableCell_%@", letter];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellIdentifier];
        //cell.layer.borderColor = [UIColor purpleColor].CGColor;
        //cell.layer.borderWidth = 3.0f;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        BCCCarousel *carousel = [self carouselForLetter:letter];
        [cell addSubview:carousel.view];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self letterAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *lettersInCaps = [NSMutableArray array];
    
    for(NSString *letter in self.letters) {
        [lettersInCaps addObject:[letter uppercaseString]];
    }
    
    return lettersInCaps;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect viewFrame = CGRectMake(0, 0, self.tableView.bounds.size.width, kCellHeaderHeight);
    UIView *view = [[UIView alloc] initWithFrame:viewFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = [title uppercaseString];
    label.font = [UIFont fontWithName:@"Georgia" size:20.0f];
    label.textColor = [UIColor colorWithRed:(110.0f / 255.0f) green:(110.0f / 255.0f) blue:(113.0f / 255.0f) alpha:1.0f];
    
    label.frame = CGRectMake(kIndexViewWidth, 0, viewFrame.size.width, viewFrame.size.height);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeaderHeight;
}

@end
