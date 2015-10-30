//
//  DBAccess.m
//  Catalog
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "DBAccess.h"

@implementation DBAccess
sqlite3 *database;
- (id)init {
    if ((self = [super init])) {
        [self initialieDataBase];
    }
    return  self;
}

- (void)initialieDataBase {
    //get the database from the application bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:@"catalog" ofType:@"db"];
    
    //open the database
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSLog(@"opening database");
    }else {
        
        //call close to properly clean up
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database: '%s'.", sqlite3_errmsg(database));
    }
}

- (void) closeDabase {
    //close the database
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Failed to close database: '%s'.", sqlite3_errmsg(database));
    }
}

- (NSMutableArray *)getAllProducts {
    //the array of product we will create
    NSMutableArray *products = [[NSMutableArray alloc] init];
    const char *sql = "SELECT product.ID, product.Name,\
    manufacturer.Name, product.Details, product.Price, \
    product.QuantityOnHand, country.Country, \
    product.Image from product, manufacturer, country \
    where manufacturer.ManufacturerID = product.ManufactureID \
    and product.CountryOfOriginID=country.CountryID";
    
    //the SQLite statement object that will hold the result set
    sqlite3_stmt *statement;
    
    //prepare the statement to compile the SQL query into byte-code
    int sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, NULL);
    
    if (sqlResult == SQLITE_OK) {
        //step through the results - once for each row
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //allocate a Product object to add to products array
            Product *product = [[Product alloc] init];
            
            //the second parameter is the colum index (0 based) in the result set
            char *name = (char *)sqlite3_column_text(statement, 1);
            char *manufacturer = (char *)sqlite3_column_text(statement, 2);
            char *details = (char *)sqlite3_column_text(statement, 3);
            char *countryOfOrigin = (char *)sqlite3_column_text(statement, 6);
            char *image = (char *)sqlite3_column_text(statement, 7);
            
            //set all the attributes of the product
            product.ID = sqlite3_column_int(statement, 0);
            product.name = (name) ? [NSString stringWithUTF8String:name] : @"";
            product.manufacture = (manufacturer) ? [NSString stringWithUTF8String:manufacturer] : @"";
            product.details = (details) ? [NSString stringWithUTF8String:details] : @"";
            product.price = sqlite3_column_double(statement, 4);
            product.quantity = sqlite3_column_int(statement, 5);
            product.CountryOfOrigin = (countryOfOrigin) ? [NSString stringWithUTF8String:countryOfOrigin] : @"";
            product.image = (image) ? [NSString stringWithUTF8String:image] : @"";
            [products addObject:product];
            
        }
        
        //finalize the statement to release its resources
        sqlite3_finalize(statement);
    }else {
        NSLog(@"problem with the database:");
        NSLog(@"%d",sqlResult);
    }
    
    return products;
}


@end
