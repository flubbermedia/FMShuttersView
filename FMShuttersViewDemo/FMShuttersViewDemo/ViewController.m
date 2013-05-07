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
    
    CGRect frame = CGRectMake(0, 0, 300, 150);
    
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
    FMShuttersView *shuttersView = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:20];
    shuttersView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
	[self.view addSubview:shuttersView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
