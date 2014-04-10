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
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CarouselItemView

- (id)initWithFrame:(CGRect)frame andModel:(CarouselItemModel *)model
{
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.model = model;
        [self render];
    }
    
    return self;
}

- (void)render
{
    NSLog(@"rendering item for model %@", self.model.title);
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.text = self.model.title;
    [self addSubview:self.titleLabel];
}

@end
