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

@property (strong, nonatomic) NSMutableArray *shutterLayers;
@property (assign, nonatomic) CGSize shutterSize;

@end

@implementation FMShuttersView

- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView numberOfShutters:(NSInteger)numberOfShutters
{
	self = [super initWithFrame:frontView.frame];
	if (self) {
		_frontView = frontView;
		_backView = backView;
		_numberOfShutters = numberOfShutters;
		
		CGFloat shutterWidth = CGRectGetWidth(_frontView.frame)/(CGFloat)_numberOfShutters;
		CGFloat shutterHeight = CGRectGetHeight(_frontView.frame);
		_shutterSize = CGSizeMake(shutterWidth, shutterHeight);
		
		[self buildShutterLayers];
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnMainView:)];
		[self addGestureRecognizer:tap];
		
		UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
		[self addGestureRecognizer:pan];
	}
	return self;
}

- (void)buildShutterLayers
{
	
	CGRect layerFrame = CGRectZero;
	layerFrame.size = _shutterSize;
	
	_shutterLayers = [NSMutableArray new];
	
	for (int i = 0; i < _numberOfShutters; i++)
	{
		CATransformLayer *baseLayer = [CATransformLayer layer];
		baseLayer.position = CGPointMake(_shutterSize.width * (i + 0.5), _shutterSize.height * 0.5);
		
		CGRect contentFrame = CGRectMake(_shutterSize.width * i, 0, _shutterSize.width, _shutterSize.height);
		
		CALayer *frontLayer = [CALayer layer];
		frontLayer.frame = layerFrame;
		frontLayer.position = CGPointMake(-_shutterSize.width * 0.5, -_shutterSize.height * 0.5);
		frontLayer.anchorPoint = CGPointMake(0.0, 0.0);
		frontLayer.doubleSided = NO;
		frontLayer.contents = (id)[self renderImageFromView:_frontView withRect:contentFrame].CGImage;
		
		CALayer *backLayer = [CALayer layer];
		backLayer.frame = layerFrame;
		backLayer.position = CGPointMake(-_shutterSize.width * 0.5, -_shutterSize.height * 0.5);
		backLayer.anchorPoint = CGPointMake(1.0, 0.0);
		backLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
		backLayer.doubleSided = NO;
		backLayer.contents = (id)[self renderImageFromView:_backView withRect:contentFrame].CGImage;
		
		CALayer *shadowLayer = [CALayer layer];
		shadowLayer.frame = layerFrame;
		shadowLayer.position = CGPointMake(-_shutterSize.width * 0.5, -_shutterSize.height * 0.5);
		shadowLayer.anchorPoint = CGPointMake(0.0, 0.0);
		shadowLayer.backgroundColor = [UIColor blackColor].CGColor;
		
		[baseLayer addSublayer:frontLayer];
		[baseLayer addSublayer:backLayer];
		[baseLayer addSublayer:shadowLayer];
		
		[self.layer addSublayer:baseLayer];
		
		[_shutterLayers addObject:baseLayer];
	}
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

- (void)didTapOnMainView:(UITapGestureRecognizer *)gesture
{
	NSLog(@"TAP");
}

- (void)didPan:(UIPanGestureRecognizer *)gesture
{
	CGPoint location = [gesture locationInView:self];
	
	if (gesture.state == UIGestureRecognizerStateBegan)
    {
		[self updateShutterLayersForLocation:location range:100 animated:YES];
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
		[self updateShutterLayersForLocation:location range:100 animated:NO];
	}
	
	if (gesture.state == UIGestureRecognizerStateEnded)
    {
		location.x = (location.x > self.bounds.size.width * 0.5) ? self.bounds.size.width : 0;
		[self updateShutterLayersForLocation:location range:0 animated:YES];
	}
}

#pragma mark - Cube transformations

- (void)updateShutterLayersForLocation:(CGPoint)location range:(CGFloat)range animated:(BOOL)animated
{
	for (CATransformLayer *layer in _shutterLayers)
	{
		CGFloat distance = layer.position.x - location.x;
		CGFloat ratio = distance / range;
		
		ratio = (ratio < 1) ? ratio : 1;
        ratio = (ratio > -1) ? ratio : -1;
		
		CGFloat angle = M_PI_2 + (M_PI_2 * ratio);
		
		animated ? nil : [CATransaction setAnimationDuration:0];
		layer.sublayerTransform = [self defaultTransform3DRotated:angle];
		
		CALayer *shadowLayer = [layer.sublayers objectAtIndex:2];
		shadowLayer.opacity = 0.8 * (1 - fabsf(ratio));
	}
}

- (CATransform3D)defaultTransform3DRotated:(CGFloat)angle
{
    CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1.0 / (4.66 * _shutterSize.width);
    transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0);
    return transform;
}

@end
