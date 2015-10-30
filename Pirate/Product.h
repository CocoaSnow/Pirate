//
//  Product.h
//  Catalog
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *manufacture;
@property (strong, nonatomic) NSString *details;
@property (nonatomic) CGFloat price;
@property (nonatomic) NSInteger quantity;
@property (strong, nonatomic) NSString *CountryOfOrigin;
@property (strong, nonatomic) NSString *image;
@property NSInteger section;

@end

