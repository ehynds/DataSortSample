//
//  CarouselItemView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "CarouselItemView.h"

@interface CarouselItemView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CarouselItemView

- (id)initWithFrame:(CGRect)frame andVideo:(NSDictionary *)video
{
    if(self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor redColor];
        self.video = video;
        [self render];
    }
    
    return self;
}

- (void)render
{
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.text = [self.video objectForKey:@"title"];
    [self addSubview:self.titleLabel];
}

@end
