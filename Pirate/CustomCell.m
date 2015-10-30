//
//  CustomCell.m
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //initialization code
        //create a frame that matches the size of the custom cell
//        CGRect viewFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        CGRect viewFrame = CGRectMake(0.0, 0.0, 375, 44);
        
        //allocate and initialize the custom view with the dimensions of the custome cell
        self.productView = [[ProductView alloc] initWithFrame:viewFrame];
        //add the custom view to the cell
        [self.contentView addSubview:self.productView];
    }
    return self;
}

- (void)setProduct:(Product *)theProduct {
    
    [self.productView setProduct:theProduct];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
