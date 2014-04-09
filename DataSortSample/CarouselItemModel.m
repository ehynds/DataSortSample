//
//  CarouselItemModel.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "CarouselItemModel.h"

@implementation CarouselItemModel

+ (id)modelWithTitle:(NSString *)title
{
    CarouselItemModel *model = [[CarouselItemModel alloc] init];
    model.title = title;
    return model;
}

@end
