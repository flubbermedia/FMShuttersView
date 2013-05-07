//
//  ViewController.m
//  FMShuttersViewDemo
//
//  Created by Andrea Ottolina on 07/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import "ViewController.h"
#import "FMShuttersView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, 280, 150);
    
    // front view
    UIImage *image = [UIImage imageNamed:@"image01.jpg"];
    UIImageView *frontView = [[UIImageView alloc] initWithFrame:frame];
    frontView.image = image;
    frontView.contentMode = UIViewContentModeScaleAspectFill;
    frontView.clipsToBounds = YES;
    
    // back view
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.backgroundColor = [UIColor purpleColor];
    
    // shutters view
    FMShuttersView *shuttersView = [[FMShuttersView alloc] initWithFrontView:frontView backView:backView numberOfShutters:10];
    shuttersView.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:shuttersView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
