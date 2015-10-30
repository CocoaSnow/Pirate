//
//  ProductView.m
//  Pirate
//
//  Created by ios－08 on 15/8/10.
//  Copyright (c) 2015年 ios－08. All rights reserved.
//

#import "ProductView.h"

@implementation ProductView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //initialization code
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //draw the Product name
    [_theProduct.name drawAtPoint:CGPointMake(45.0, 0.0) withAttributes:@{
    NSFontAttributeName:[UIFont systemFontOfSize:20.0],
//    NSForegroundColorAttributeName: [UIColor greenColor],
    NSStrokeWidthAttributeName: @5,
    NSStrokeColorAttributeName: [UIColor redColor],
    NSUnderlineColorAttributeName:@(NSUnderlineStyleSingle),
    NSBackgroundColorAttributeName:[UIColor colorWithWhite:0.8 alpha:0.5],
    }];
    
    //draw the manufacturer label
    [_theProduct.manufacture drawAtPoint:CGPointMake(45.0, 25.0) withAttributes:@{
                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:13.0],
                                                                                  //    NSForegroundColorAttributeName: [UIColor greenColor],
                                                                                  NSStrokeWidthAttributeName: @3.5,
                                                                                  NSStrokeColorAttributeName: [UIColor darkTextColor],
                                                                                  NSUnderlineColorAttributeName:@(NSUnderlineStyleSingle),
                                                                                  NSBackgroundColorAttributeName:[UIColor colorWithWhite:0.8 alpha:0.5],
                                                                                  }];
    
    //draw pricen label
    [[NSString stringWithFormat:@"$ %.2f",_theProduct.price] drawAtPoint:CGPointMake(185.0, 10.0) withAttributes:@{
                                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:22.0],
                                                                                                               //    NSForegroundColorAttributeName: [UIColor greenColor],
                                                                                                               NSStrokeWidthAttributeName: @3.5,
                                                                                                               NSStrokeColorAttributeName: [UIColor brownColor],
                                                                                                               NSUnderlineColorAttributeName:@(NSUnderlineStyleSingle),
                                                                                                               NSBackgroundColorAttributeName:[UIColor colorWithWhite:0.8 alpha:0.5],
                                                                                                               }];
    //draw the images
    UIImage *image = [UIImage imageNamed:@"ic_lptheme_phone"];
    [image drawInRect:CGRectMake(5.2, 5.2, 35.0, 35.0)];
    
    UIImage *navImage = [UIImage imageNamed:@"sms_selected"];
    [navImage drawInRect:CGRectMake(280, 5.2, 35.0, 35.0)];
    
    UIImage *rigImage = [UIImage imageNamed:@"blue"];
    [rigImage drawInRect:CGRectMake(330, 5.2, 35.0, 35.0)];
    
}

- (void)setProduct:(Product *)inputProduct {
    //if a different Product is passed in ...
    if (_theProduct != inputProduct) {
        _theProduct = inputProduct;
    }
    //mark the view to be redrawn
    [self setNeedsDisplay];
}

@end
