//
//  MasterViewController.m
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CustomCell.h"
#import "SearchResultsTableViewController.h"

@interface MasterViewController () <UISearchResultsUpdating>

@property (nonatomic,strong)SearchResultsTableViewController *searchResultsController;

@end

@implementation MasterViewController

#pragma mark pushToDetails delegate

-(SearchResultsTableViewController *)searchResultsController {
    if (!_searchResultsController) {
        _searchResultsController = [[SearchResultsTableViewController alloc] init];
    }
    return _searchResultsController;
}

- (void)pushToDetail:(Product *)theProduct{
    
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] init];
    }

    self.detailViewController.detailItem = theProduct;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set seperator
    self.tableView.separatorColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:0.8];
    
    //
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertObject:inProductsAtIndex:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController = searchController;
    
    //设置更新搜索结果代理
    searchController.searchResultsUpdater = self;
    
    //设置允许在当前界面切换展示数据的上下文
    self.definesPresentationContext = YES;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = _searchController.searchBar;

    
//-------------------------------------------
    //register cell class
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomerCell"];
    
    //set title
    self.title = NSLocalizedString(@"Product", @"title");
    
    //set  the products
    self.products = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *productsTemp;
    
    //get the DBAccess object
    DBAccess *dbAccess = [[DBAccess alloc] init];
    
    //get the products array from the database
    productsTemp = [dbAccess getAllProducts];
    
    //close the database because we are finished with it
    [dbAccess closeDabase];
    
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    //iterate over the produccts, populating their section number
    for (Product *theProduct in productsTemp) {
        NSInteger section = [indexedCollation sectionForObject:theProduct collationStringSelector:@selector(name)];
        theProduct.section = section;
    }
    
    //get the count of the number of sections
    NSInteger sectionCount = [[indexedCollation sectionTitles] count];
    
    //get an array to hold the subarrays
    NSMutableArray *sectionsArray = [NSMutableArray arrayWithCapacity:sectionCount];
    
    //iterate over each section, create each subarray
    for (int i = 0; i < sectionCount; i++) {
        NSMutableArray *singleSectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionsArray addObject:singleSectionArray];
    }
    
    //iterate over the products, putting each product into the correct subarray
    for (Product *theProduct in productsTemp) {
        [(NSMutableArray *)[sectionsArray objectAtIndex:theProduct.section] addObject:theProduct];
    }
    
    //iterate over each section array to sort the items in the section
    for (NSMutableArray *singleSectionArray in sectionsArray) {
        NSArray *sortedSection = [indexedCollation sortedArrayFromArray:singleSectionArray collationStringSelector:@selector(name)];
        [self.products addObject:sortedSection];
    }
    
}

#pragma mark - delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    //you need the count for the filtered table
    //first, flatten the array of arrays self.products
    NSMutableArray *flattenedArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSMutableArray *theArray in self.products) {
        for (int i=0; i < [theArray count]; i++) {
            [flattenedArray addObject:[theArray objectAtIndex:i]];
        }
    }
    
    //set up an NSPredicate to filter the rows
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@",searchController.searchBar.text];
    NSArray *filteredProducts = [flattenedArray filteredArrayUsingPredicate:predicate];
    NSLog(@"-----------------------------------");
    NSLog(@"filtered:%@",filteredProducts);
    self.searchResultsController.filteredResults = filteredProducts;
    [self.searchResultsController.tableView reloadData];
    
}

#pragma mark - insert button
- (void)insertObject:(NSArray *)object inProductsAtIndex:(NSIndexPath*)index {
    if (!self.products) {
        self.products = [[NSMutableArray alloc] init];
    }
    Product *newProduct = [self createNewProduct];
    NSArray *single = [NSArray arrayWithObject:newProduct];
    [self.products insertObject: single atIndex:0];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}

/*
 the Product properties
 @property (nonatomic) int ID;
 @property (strong, nonatomic) NSString *name;
 @property (strong, nonatomic) NSString *manufacture;
 @property (strong, nonatomic) NSString *details;
 @property (nonatomic) float price;
 @property (nonatomic) int quantity;
 @property (strong, nonatomic) NSString *CountryOfOrigin;
 @property (strong, nonatomic) NSString *image;
 */
-(Product *)createNewProduct {
    Product *theProduct = [[Product alloc] init];
    theProduct.ID = 55;
    theProduct.name = @"name";
    theProduct.manufacture = @"manufactrue";
    theProduct.details = @"details";
    theProduct.price = 3.33;
    theProduct.quantity = 22;
    theProduct.CountryOfOrigin = @"CountryOfOrigin";
    theProduct.image = @"image";
    theProduct.section = 0;
    return  theProduct;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Product *object = [self.products[indexPath.section] objectAtIndex:[indexPath row]];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return [self.products count];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.products objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CustomCell"];
    }
    //config the cell
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //get the Product object
    Product *theProduct = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        
    //set the product to be used to draw the cell
    [cell setProduct:theProduct];
        
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //make sure the section will contain some data
    if ([[self.products objectAtIndex:section] count] > 0) {
        
        //get the section title from the UILocalizedIndexedCollation object
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //link the sections to the labels in the index
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Product *theProduct;
    //get the Product that correspounds with the touched table cell
        theProduct = [[self.products objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    //push to detailViewController
    [self pushToDetail:theProduct];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return indexPath.section < 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.products removeObjectAtIndex:indexPath.section];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end