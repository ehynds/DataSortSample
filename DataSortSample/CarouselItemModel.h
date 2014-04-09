//
//  CarouselItemModel.h
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselItemModel : NSObject

+ (id)modelWithTitle:(NSString *)title;

@property(nonatomic, strong) NSString *title;

@end
