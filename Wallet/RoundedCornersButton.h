//
//  RoundedCornersButton.h
//  Wallet
//
//  Created by Serhii Kovtunenko on 8/25/18.
//  Copyright © 2018 Serhii Kovtunenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedCornersButton : UIButton

@property (assign) IBInspectable CGFloat cornerRadius;
@property (assign) CGColorRef *shadowColor;
@property (assign) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) NSString *buttonTitle;
@property (nonatomic) NSString *buttonDescription;

@end
