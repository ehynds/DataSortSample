//
//  ViewController.m
//  DataSortSample
//
//  Created by Matthew Propst on 4/4/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    return [self.recipes count];
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
    }
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 60)];
    UIView *redRectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 60)];
    [redRectangle setBackgroundColor:[UIColor redColor]];
    UIButton *redBtnInfo = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 300, 50)];
    [redBtnInfo setBackgroundColor:[UIColor blackColor]];
    [redBtnInfo setTag:indexPath.row];
    [redBtnInfo addTarget:self action:@selector(logRow:) forControlEvents:UIControlEventTouchUpInside];
    [redBtnInfo setTitle:@"Log Red Message" forState:UIControlStateNormal];
    [redRectangle addSubview:redBtnInfo];
    [sv addSubview:redRectangle];
    
    UIView *greenRectangle = [[UIView alloc] initWithFrame:CGRectMake(800, 0, 800, 60)];
    [greenRectangle setBackgroundColor:[UIColor greenColor]];
    
    UIButton *greenBtnInfo = [[UIButton alloc] initWithFrame:CGRectMake(200, 5, 300, 50)];
    [greenBtnInfo setBackgroundColor:[UIColor blackColor]];
    [greenBtnInfo setTag:indexPath.row];
    [greenBtnInfo addTarget:self action:@selector(logGreenRow:) forControlEvents:UIControlEventTouchUpInside];
    [greenBtnInfo setTitle:@"Log Green Message" forState:UIControlStateNormal];
    [greenRectangle addSubview:greenBtnInfo];
    [sv addSubview:greenRectangle];
    
    sv.contentSize = CGSizeMake(1600, 60);
    sv.delegate = self;
    [cell addSubview:sv];
    cell.textLabel.text = [self.recipes objectAtIndex:indexPath.row];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title
               atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

-(void)logRow:(UIButton*)sender{
        NSLog(@"Red button - row number: %i", sender.tag+1);
}

-(void)logGreenRow:(UIButton*)sender{
    NSLog(@"Green button - row number: %i", sender.tag+1);
}

@end
