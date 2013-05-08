//
//  ShuttersCell.m
//  ShuttersTable
//
//  Created by Maurizio Cremaschi on 07/05/2013.
//  Copyright (c) 2013 Flubber Media Ltd. All rights reserved.
//

#import "ShuttersCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShuttersCell

- (void)awakeFromNib
{
    self.textLabel.text = nil;
    self.darkView.alpha = 0;
    
    self.layer.anchorPoint = CGPointMake(0.5, 1);
    self.layer.doubleSided = NO;
}

@end
