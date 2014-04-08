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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.recipes = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1; // [self.recipes count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
        SwipeView *swipeView = [[SwipeView alloc] initWithFrame:cell.bounds];
        swipeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        swipeView.delegate = self;
        swipeView.dataSource = self;
        swipeView.truncateFinalPage = YES;
        swipeView.pagingEnabled = NO;
        
        [cell addSubview:swipeView];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellMarginTop + kCellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
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

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.recipes count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
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
    
    label.text = [self.recipes objectAtIndex:index];
    
    return view;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"Selected %@", self.recipes[index]);
    // UIView *selectedView = [swipeView itemViewAtIndex:index];
}

@end
