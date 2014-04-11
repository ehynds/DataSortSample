//
//  CarouselItemView.m
//  DataSortSample
//
//  Created by Eric Hynds on 4/9/14.
//  Copyright (c) 2014 Matthew Propst. All rights reserved.
//

#import "CarouselItemView.h"

@interface CarouselItemView()

@property (nonatomic, strong) UIView *thumbnail;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation CarouselItemView

- (id)initWithFrame:(CGRect)frame andVideo:(NSDictionary *)video
{
    if(self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        //self.layer.borderColor = [UIColor redColor].CGColor;
        //self.layer.borderWidth = 1.0f;
        self.video = video;
        [self render];
    }
    
    return self;
}

- (CGFloat)getLabelHeight:(UILabel *)label withFont:(UIFont *)font
{
    CGFloat width = label.frame.size.width;
    CGFloat height = label.frame.size.height;
    CGSize textSize = [label.text sizeWithFont:font
                         constrainedToSize:CGSizeMake(width, height)
                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return textSize.height;
}

- (void)render
{
    CGRect thumbRect = CGRectMake(0, 0, self.bounds.size.width, 156);
    self.thumbnail = [[UIView alloc] initWithFrame:thumbRect];
    self.thumbnail.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.thumbnail];
    
    CGRect titleRect = CGRectMake(0, thumbRect.size.height + 4, self.frame.size.width, 50);
    UIFont *titleFont = [UIFont fontWithName:@"Georgia" size:18.0f];
    self.titleLabel = [[UILabel alloc] initWithFrame:titleRect];
    self.titleLabel.text = [self.video objectForKey:@"title"];
    self.titleLabel.font = titleFont;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.adjustsFontSizeToFitWidth = NO;
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    //self.titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //self.titleLabel.layer.borderWidth = 1.0f;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];
    
    // Measure the title label since we need to position the date label directly underneath it
    int titleHeight = [self getLabelHeight:self.titleLabel withFont:titleFont];
    int titleY = titleRect.origin.y + titleHeight;
    
    CGRect dateLabel = CGRectMake(0, titleY, self.frame.size.width, 25);
    self.dateLabel = [[UILabel alloc] initWithFrame:dateLabel];
    self.dateLabel.text = [self.video objectForKey:@"publishedDate"];
    self.dateLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f]; // [UIFont systemFontOfSize:14.0f];
    self.dateLabel.textColor = [UIColor colorWithRed:(88.0f/255.0f) green:(89.0f/255.0f) blue:(91.0f/255.0f) alpha:1.0f];
    //self.dateLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //self.dateLabel.layer.borderWidth = 1.0f;
    [self addSubview:self.dateLabel];
}

@end
