//
//  SearchResultsTableViewController.h
//  Pirate
//
//  Created by ios－08 on 15/8/12.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface SearchResultsTableViewController : UITableViewController

@property (strong, nonatomic)NSArray *filteredResults;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
