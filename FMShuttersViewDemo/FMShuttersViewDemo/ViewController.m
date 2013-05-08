//
//  ViewController.m
//  FMShuttersViewDemo
//
//  Created by Andrea Ottolina on 07/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import "ViewController.h"
#import "FMShuttersView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, 300, 120);
    
    // front view
    UIImage *image1 = [UIImage imageNamed:@"img01.jpg"];
    UIImageView *frontView = [[UIImageView alloc] initWithFrame:frame];
    frontView.image = image1;
    frontView.contentMode = UIViewContentModeScaleAspectFill;
    frontView.clipsToBounds = YES;
    
    // back view
    UIImage *image2 = [UIImage imageNamed:@"img02.jpg"];
    UIImageView *backView = [[UIImageView alloc] initWithFrame:frame];
    backView.image = image2;
    backView.contentMode = UIViewContentModeScaleAspectFill;
    backView.clipsToBounds = YES;
    
    // shutters view
    FMShuttersView *shuttersView1 = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:20];
    shuttersView1.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(frame)/2 + 10 + 0 * (10 + CGRectGetHeight(frame)));
	[self.view addSubview:shuttersView1];
	
	FMShuttersView *shuttersView2 = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:20];
    shuttersView2.type = ShutterTypeCenterUp;
	shuttersView2.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(frame)/2 + 10 + 1 * (10 + CGRectGetHeight(frame)));
	[self.view addSubview:shuttersView2];
	
	FMShuttersView *shuttersView3 = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:20];
    shuttersView3.type = ShutterTypeAlignedDown;
	shuttersView3.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(frame)/2 + 10 + 2 * (10 + CGRectGetHeight(frame)));
	[self.view addSubview:shuttersView3];
	
	FMShuttersView *shuttersView4 = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:20];
    shuttersView4.type = ShutterTypeAlignedUp;
	shuttersView4.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(frame)/2 + 10 + 3 * (10 + CGRectGetHeight(frame)));
	[self.view addSubview:shuttersView4];
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
