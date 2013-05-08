//
//  TableViewController.m
//  FMShuttersViewDemo
//
//  Created by Maurizio Cremaschi on 08/05/2013.
//  Copyright (c) 2013 Flubber Media. All rights reserved.
//

#import "TableViewController.h"
#import "ShuttersCell.h"
#import <QuartzCore/QuartzCore.h>

@interface TableViewController ()

@property (strong, nonatomic) NSArray *datasource;

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *m_datasource = [NSMutableArray new];
    for (int i=0; i<100; i++) {
        [m_datasource addObject:@{
         @"color": [UIColor colorWithHue:(arc4random()%100)*0.01 saturation:0.3 brightness:0.8 alpha:1.0],
         @"text": [NSString stringWithFormat:@"Row %.2d", i],
         }];
    }
    _datasource = [NSArray arrayWithArray:m_datasource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShuttersCell";
    ShuttersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dict = [_datasource objectAtIndex:indexPath.row];
    
    cell.label.text = dict[@"text"];
    cell.coloredView.backgroundColor = dict[@"color"];
    cell.darkView.alpha = 0;
    
    cell.layer.transform = CATransform3DIdentity;
    cell.layer.zPosition = -1000;
    cell.clipsToBounds = NO;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        for (ShuttersCell *cell in self.tableView.visibleCells) {
            
            NSInteger index = [self.tableView.visibleCells indexOfObject:cell];
            CGFloat rotationFactor = (self.tableView.visibleCells.count - index) * 0.2;
            CGFloat angle = M_PI_2/180*scrollView.contentOffset.y*rotationFactor;
            //CGFloat angle = M_PI_2/180*scrollView.contentOffset.y;
            CGFloat alpha = 0;
            
            CATransform3D t = CATransform3DIdentity;
            if (scrollView.contentOffset.y < 0) {
                t.m34 = 1/500.;
                //t = CATransform3DTranslate(t, 0, fabs(index * scrollView.contentOffset.y * 0.2), 0);
                t = CATransform3DRotate(t, angle, 1, 0, 0);
                
                alpha = fabs(0.5/M_PI*2*angle);
            }
            
            cell.layer.transform = t;
            
            cell.darkView.alpha = alpha;
        }
    }
}

@end
