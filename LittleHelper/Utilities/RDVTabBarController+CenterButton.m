//
//  RDVTabBarController+CenterButton.m
//  zfbuser
//
//  Created by Eric Wang on 15/7/14.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "RDVTabBarController+CenterButton.h"

@implementation RDVTabBarController (CenterButton)

// Create a custom UIButton and add it to the center of our tab bar
- (UIButton *)addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setImage:highlightImage forState:UIControlStateSelected];

    button.userInteractionEnabled = NO;
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0){
        CGPoint center = self.tabBar.center;
        center.y = center.y - 10;
        button.center = center;
    }
    else{
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.tabBar addSubview:button];
    return button;
}

@end
