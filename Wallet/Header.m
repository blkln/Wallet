//
//  Header.m
//  Wallet
//
//  Created by Serhii Kovtunenko on 8/25/18.
//  Copyright © 2018 Serhii Kovtunenko. All rights reserved.
//

#import "Header.h"

@interface Header ()

@end

@implementation Header

-(void)awakeFromNib
{
    [super awakeFromNib];
//    self.backgoundGradientView.layer.mask = gradientMask;
}

-(void)layout
{
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIColor *firstColor = [UIColor colorWithRed:58.0 / 255.0 green:56.0 / 255.0 blue:196.0 / 255.0 alpha:1];
    UIColor *secondColor = [UIColor colorWithRed:228.0 / 255.0 green:50.0 / 255.0 blue:78.0 / 255.0 alpha:1];
    gradientMask.colors = @[(id)firstColor.CGColor, (id)secondColor.CGColor];
    gradientMask.startPoint = CGPointMake(0.0, 0.5);
    gradientMask.endPoint = CGPointMake(1.0, 0.5);
    [self.backgoundGradientView.layer addSublayer:gradientMask];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
