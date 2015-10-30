//
//  DBAccess.h
//  Catalog
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Product.h"

@interface DBAccess : NSObject

- (NSMutableArray *)getAllProducts;
- (void)closeDabase;
- (void)initialieDataBase;

@end
