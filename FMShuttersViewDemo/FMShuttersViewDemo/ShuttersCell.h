//
//  ShuttersCell.h
//  ShuttersTable
//
//  Created by Maurizio Cremaschi on 07/05/2013.
//  Copyright (c) 2013 Flubber Media Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuttersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *coloredView;
@property (weak, nonatomic) IBOutlet UIView *darkView;

@end
