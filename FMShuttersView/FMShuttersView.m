//
//  FMShuttersView.m
//  FMShuttersViewDemo
//
//  Created by Andrea Ottolina on 07/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import "FMShuttersView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FMShuttersView

- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView
{
	//
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSArray *)splittedLayersForView:(UIView *)view
{
    NSMutableArray *m_layers = [NSMutableArray new];
    
    int numberOfSlices = 10;
    for (int i=0; i<numberOfSlices; i++) {
        CGFloat width = CGRectGetWidth(view.frame)/numberOfSlices;
        CGRect frame = CGRectMake(width * i, 0, width, CGRectGetHeight(view.frame));
        CALayer *layer = [CALayer layer];
        layer.contents = (id)[self renderImageFromView:view withRect:frame].CGImage;
        layer.frame = frame;
        [self.layer addSublayer:layer];
        [m_layers addObject:layer];
    }
    
    view.hidden = YES;
    
    return [NSArray arrayWithArray:m_layers];
}

- (UIImage *)renderImageFromView:(UIView *)view withRect:(CGRect)frame
{
	UIGraphicsBeginImageContextWithOptions(frame.size, YES, 0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
    [view.layer renderInContext:context];
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderedImage;
}

@end
