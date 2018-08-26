//
//  RoundedCornersButton.m
//  Wallet
//
//  Created by Serhii Kovtunenko on 8/25/18.
//  Copyright © 2018 Serhii Kovtunenko. All rights reserved.
//

#import "RoundedCornersButton.h"

@implementation RoundedCornersButton

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

-(void)setShadowColor
{
    self.layer.shadowColor = [[UIColor grayColor]CGColor];
}

-(CGColorRef)shadowColor
{
    return self.layer.shadowColor;
}

-(void)setShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity;
}

-(CGFloat)shadowOpacity
{
    return self.layer.shadowOpacity;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
