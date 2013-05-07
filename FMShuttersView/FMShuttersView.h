//
//  FMShuttersView.h
//  FMShuttersViewDemo
//
//  Created by Andrea Ottolina on 07/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMShuttersView : UIView

@property (readonly) UIView *frontView;
@property (readonly) UIView *backView;
@property (readonly) NSInteger numberOfShutters;

- (id)initWithFrontView:(UIView *)frontView backView:(UIView *)backView numberOfShutters:(NSInteger)numberOfShutters;

@end
