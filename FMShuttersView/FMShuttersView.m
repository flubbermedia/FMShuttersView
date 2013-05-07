//
//  FMShuttersView.m
//  FMShuttersViewDemo
//
//  Created by Andrea Ottolina on 07/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import "FMShuttersView.h"
#import <QuartzCore/QuartzCore.h>

@interface FMShuttersView ()

@property (strong, nonatomic) NSArray *frontLayers;
@property (strong, nonatomic) NSArray *backLayers;

@end

@implementation FMShuttersView

- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView numberOfShutters:(NSInteger)numberOfShutters
{
    self = [super initWithFrame:frontView.frame];
    if (self) {
		_frontView = frontView;
        _backView = backView;
        _numberOfShutters = numberOfShutters;
        _frontLayers = [self splittedLayersForView:_frontView];
        _backLayers = [self splittedLayersForView:_backView];
        
        // *******************
        // TEMPORARY TEST CODE
        // *******************
        for (CALayer *layer in _frontLayers) {
            [self.layer addSublayer:layer];
        }
        self.clipsToBounds = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnMainView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (NSArray *)splittedLayersForView:(UIView *)view
{
    NSMutableArray *m_layers = [NSMutableArray new];
    for (int i=0; i<_numberOfShutters; i++) {
        CGFloat width = CGRectGetWidth(view.frame)/(CGFloat)_numberOfShutters;
        CGRect frame = CGRectMake(width * i, 0, width, CGRectGetHeight(view.frame));
        CALayer *layer = [CALayer layer];
        layer.contents = (id)[self renderImageFromView:view withRect:frame].CGImage;
        layer.frame = frame;
        [m_layers addObject:layer];
    }    
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

- (void)didTapOnMainView:(UITapGestureRecognizer *)tap
{
    for (CALayer *layer in _frontLayers) {
        layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, arc4random()%50, 0);
    }
}

@end
