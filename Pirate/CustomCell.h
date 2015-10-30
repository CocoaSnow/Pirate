//
//  CustomCell.h
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductView.h"

@interface CustomCell : UITableViewCell {
}

@property (nonatomic, strong) ProductView *productView;

- (void)setProduct:(Product *)theProduct;

@end
