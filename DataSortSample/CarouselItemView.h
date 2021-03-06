//
//  CarouselItemView.h
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselItemModel;

@interface CarouselItemView : UIView

- (id)initWithFrame:(CGRect)frame andVideo:(NSDictionary *)video;

@property (nonatomic, copy) NSDictionary *video;

@end
