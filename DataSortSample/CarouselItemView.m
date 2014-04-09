//
//  CarouselItemView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "CarouselItemView.h"
#import "CarouselItemModel.h"

@interface CarouselItemView()

@property (nonatomic, strong) CarouselItemModel *model;
@property (nonatomic, strong) UILabel *title;

@end

@implementation CarouselItemView

- (id)initWithFrame:(CGRect)frame andModel:(CarouselItemModel *)model
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.model = model;
    }
    
    [self render];
    
    return self;
}

- (void)render
{
    self.title = [[UILabel alloc] initWithFrame:self.bounds];
    self.title.text = self.model.title;
    [self addSubview:self.title];
}

@end
