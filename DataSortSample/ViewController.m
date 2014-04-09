//
//  ViewController.m
//  DataSortSample
//
//  Created by Matthew Propst on 4/4/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <SwipeView/SwipeView.h>
#import "ViewController.h"

#define kCellWidth 200
#define kCellHeight 200
#define kCellMarginTop 25
#define kCellMarginBottom 50
#define kCellHeaderHeight 25

@interface ViewController () <SwipeViewDataSource, SwipeViewDelegate>

@property(nonatomic, strong) NSMutableDictionary *recipeDict;
@property(nonatomic, strong) NSMutableDictionary *carousels;
@property(nonatomic, strong) NSArray *letters;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.recipes = @[@"Egg Benedict",
                     @"Mushroom Risotto",
                     @"Full Breakfast",
                     @"Hamburger",
                     @"Ham and Egg Sandwich",
                     @"Creme Brelee",
                     @"Pound Cake",
                     @"Pancakes",
                     @"Black Bean Soup",
                     @"Ginger Bread",
                     @"Vegetable Stir Fry",
                     @"Omlette",
                     @"Candied Apples",
                     @"Apple Pie",
                     @"Applesauce",
                     @"White Chocolate Donut",
                     @"Starbucks Coffee",
                     @"Vegetable Curry",
                     @"Instant Noodle with Egg",
                     @"Noodle with BBQ Pork"];
    
    self.recipeDict = [self groupByAlpha];
    self.letters = [[self.recipeDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // Create a carousel for each row
    self.carousels = [NSMutableDictionary dictionary];
    for(NSString *letter in self.letters) {
        SwipeView *carousel = [[SwipeView alloc] initWithFrame:CGRectZero];
        carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        carousel.delegate = self;
        carousel.dataSource = self;
        carousel.truncateFinalPage = YES;
        carousel.pagingEnabled = NO;
        self.carousels[letter] = carousel;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)groupByAlpha
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for(NSString *recipe in self.recipes) {
        NSString *dictKey = [[NSString stringWithFormat:@"%c", [recipe characterAtIndex:0]] lowercaseString];
        
        if([ret objectForKey:dictKey] == nil) {
            [ret setObject:[NSMutableArray array] forKey:dictKey];
        }
        
        [[ret objectForKey:dictKey] addObject:recipe];
    }
    
    return ret;
}

- (NSString *)letterAtIndex:(NSInteger)index
{
    return [self.letters objectAtIndex:index];
}

// Returns the carousel associated with a given letter
- (NSString *)letterForCarousel:(SwipeView *)carousel
{
    for(NSString *letter in self.recipeDict) {
        if([self.carousels objectForKey:letter] == carousel) {
            return letter;
        }
    }
    
    return @"";
}

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
        SwipeView *carousel = [self.carousels objectForKey:letter];
        carousel.frame = cell.bounds;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addSubview:carousel];
    }
    NSLog(@"Creating cell for letter %@, section index is %d", [self letterAtIndex:indexPath.section], indexPath.section);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellMarginTop + kCellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self letterAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.letters;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor grayColor];
    label.text = title;
    [label sizeToFit];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kCellMarginBottom;
}

#pragma mark - swipe view delegate methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)carousel
{
    NSString *letter = [self letterForCarousel:carousel];
    return [[self.recipeDict objectForKey:letter] count];
}

- (UIView *)swipeView:(SwipeView *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    if(view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, kCellMarginTop, kCellWidth, kCellHeight)];
        view.contentMode = UIViewContentModeCenter;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = [UIColor blackColor].CGColor;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:20];
        label.tag = 1;
        [view addSubview:label];
    } else {
        label = (UILabel *)[view viewWithTag:1];
    }
    
    NSArray *recipes = [self.recipeDict objectForKey:[self letterForCarousel:carousel]];
    NSLog(@"Recipies for letter %@ are %@", [self letterForCarousel:carousel], recipes);
    label.text = [recipes objectAtIndex:index];
    
    return view;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Selected %@", self.recipes[index]);
    // UIView *selectedView = [swipeView itemViewAtIndex:index];
}

@end
