//
//  DetailViewController.h
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *manufacturerLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantiryLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;

- (void)dismiss;

@end

