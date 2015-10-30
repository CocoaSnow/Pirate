//
//  MasterViewController.h
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Product.h"
#import "DBAccess.h"

@protocol pushToDetailsDelegate <NSObject>

- (void)pushToDetail:(Product *)theProduct;

@end

@interface MasterViewController : UITableViewController  <UISearchControllerDelegate, pushToDetailsDelegate,UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *products;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) UISearchController *searchController;

@property (nonatomic, strong) UISearchBar *searchBar;

@end

