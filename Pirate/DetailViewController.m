//
//  DetailViewController.m
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "DetailViewController.h"
#import "Product.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Product *theProduct = (Product *)self.detailItem;
        
        //set the text of labels to the values passed in the Product object
        self.nameLabel.text = theProduct.name;
        self.manufacturerLabel.text = theProduct.manufacture;
        self.detailsLabel.text = theProduct.details;
        self.priceLabel.text = [NSString stringWithFormat:@"%.2f", theProduct.price];
        self.quantiryLabel.text = [NSString stringWithFormat:@"%ld", (long)theProduct.quantity];
        self.countryLabel.text = theProduct.CountryOfOrigin;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"details";
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
