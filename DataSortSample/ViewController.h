//
//  ViewController.h
//  DataSortSample
//
//  Created by Matthew Propst on 4/4/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, CarouselViewDelegate>

@property (strong) IBOutlet UITableView *tableView;
@property (strong) UICollectionView *collectionView;
@property (strong) NSArray *videos;

@end
