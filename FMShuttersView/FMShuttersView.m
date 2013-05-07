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
		CATransformLayer *baseLayer3D = [CATransformLayer layer];
		baseLayer3D.position = CGPointMake(_shutterSize.width * (i + 0.5), _shutterSize.height * 0.5);
		
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
		
		[baseLayer3D addSublayer:frontLayer];
		[baseLayer3D addSublayer:backLayer];
		
		[self.layer addSublayer:baseLayer3D];
		
		[_shutterLayers addObject:baseLayer3D];
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

- (void)didTapOnMainView:(UITapGestureRecognizer *)tap
{
	NSLog(@"TAP");
}

- (void)didPan:(UIPanGestureRecognizer *)pan
{
	CGPoint distanceFromOrigin = [pan locationInView:self];
	
	for (CATransformLayer *layer in _shutterLayers)
	{
		CGFloat angle = M_PI_2 * distanceFromOrigin.x / 50.0; //(distanceFromOrigin.x / self.bounds.size.width);
		
		NSLog(@"%f", angle);
		[CATransaction setAnimationDuration:0];
		layer.sublayerTransform = [self defaultTransform3DRotated:angle zoom:0];
	}
}

- (CATransform3D)defaultTransform3DRotated:(CGFloat)angle zoom:(CGFloat)zoom
{
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1.0 / (4.66 * _shutterSize.width);
	//transform = CATransform3DTranslate(transform, 0.0, 0.0, -_shutterSize.width * 0.5 + zoom);
	transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0);
	//transform = CATransform3DTranslate(transform, 0.0, 0.0, _shutterSize.width * 0.5 + zoom);
	return transform;
}

@end
