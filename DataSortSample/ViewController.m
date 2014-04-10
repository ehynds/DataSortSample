//
//  ViewController.m
//  DataSortSample
//
//  Created by Matthew Propst on 4/4/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BCCCarouselView.h"
#import "CarouselItemView.h"
#import "CarouselItemModel.h"
#import "ViewController.h"


#define kIndexViewWidth 30
#define kCellWidth 165
#define kCellHeight 175
#define kCellHorizontalSpacing 15
#define kCellMarginTop 20
#define kCellMarginBottom 50
#define kCellHeaderHeight 25

@interface ViewController ()

@property(nonatomic, strong) NSMutableDictionary *recipeDict;
@property(nonatomic, strong) NSMutableDictionary *carousels;
@property(nonatomic, strong) NSArray *letters;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // In practice these will probably already be video objects
    self.recipes = @[[CarouselItemModel modelWithTitle:@"Egg Benedict"],
                     [CarouselItemModel modelWithTitle:@"Mushroom Risotto"],
                     [CarouselItemModel modelWithTitle:@"Full Breakfast"],
                     [CarouselItemModel modelWithTitle:@"Hamburger"],
                     [CarouselItemModel modelWithTitle:@"Ham and Egg Sandwich"],
                     [CarouselItemModel modelWithTitle:@"Anchovy Cup Cakes"],
                     [CarouselItemModel modelWithTitle:@"A1 Steak Sauce"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Almond Butter"],
                     [CarouselItemModel modelWithTitle:@"Alaskan King Salmon"],
                     [CarouselItemModel modelWithTitle:@"Alphabet Soup"],
                     [CarouselItemModel modelWithTitle:@"Butternut Squash"],
                     [CarouselItemModel modelWithTitle:@"Creme Brelee"],
                     [CarouselItemModel modelWithTitle:@"Pound Cake"],
                     [CarouselItemModel modelWithTitle:@"Pancakes"],
                     [CarouselItemModel modelWithTitle:@"Black Bean Soup"],
                     [CarouselItemModel modelWithTitle:@"Ginger Bread"],
                     [CarouselItemModel modelWithTitle:@"Vegetable Stir Fry"],
                     [CarouselItemModel modelWithTitle:@"Omlette"],
                     [CarouselItemModel modelWithTitle:@"Candied Apples"],
                     [CarouselItemModel modelWithTitle:@"Apple Pie"],
                     [CarouselItemModel modelWithTitle:@"Applesauce"],
                     [CarouselItemModel modelWithTitle:@"White Chocolate Donut"],
                     [CarouselItemModel modelWithTitle:@"Starbucks Coffee"],
                     [CarouselItemModel modelWithTitle:@"Vegetable Curry"],
                     [CarouselItemModel modelWithTitle:@"Instant Noodle with Egg"],
                     [CarouselItemModel modelWithTitle:@"Noodle with BBQ Pork"]];
    
    self.recipeDict = [self groupByAlpha];
    self.letters = [[self.recipeDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

#pragma mark - Carousel delegate methods

- (UIView *)viewForCarouselItem:(id)model frame:(CGRect)frame
{
    UIView *itemView = [[CarouselItemView alloc] initWithFrame:frame andModel:model];
    itemView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return itemView;
}

#pragma mark - Utility functions

// Creates a carousel for a given letter if it hasn't already been created yet.
- (BCCCarouselView *)carouselForLetter:(NSString *)letter
{
    if(!self.carousels) {
        self.carousels = [NSMutableDictionary dictionary];
    }
    
    BCCCarouselView *carousel;
    
    if((carousel = [self.carousels objectForKey:letter])) {
        return carousel;
    }
    
    CGRect frame = CGRectMake(0, 0, self.tableView.bounds.size.width, kCellHeight);
    
    carousel = [[BCCCarouselView alloc] initWithFrame:frame
                                         itemWidth:kCellWidth
                                       itemSpacing:kCellHorizontalSpacing
                                       edgeSpacing: kIndexViewWidth];
    
    carousel.delegate = self;
    [carousel populateWithModels:[self.recipeDict objectForKey:letter]];
    self.carousels[letter] = carousel;
    
    return carousel;
}

// Creates a dictionary from the recipes where the key is the letter and the
// value is an array of models
- (NSMutableDictionary *)groupByAlpha
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for(CarouselItemModel *recipe in self.recipes) {
        NSString *dictKey = [[NSString stringWithFormat:@"%c", [recipe.title characterAtIndex:0]] lowercaseString];
        
        if([ret objectForKey:dictKey] == nil) {
            [ret setObject:[NSMutableArray array] forKey:dictKey];
        }
        
        [[ret objectForKey:dictKey] addObject:recipe];
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addSubview:[self carouselForLetter:letter]];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellMarginTop + kCellMarginBottom + kCellHeight;
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
    
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor grayColor];
    label.text = [title uppercaseString];
    label.frame = CGRectMake(kIndexViewWidth, 0, viewFrame.size.width, viewFrame.size.height);
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kCellHeaderHeight;
}

@end
