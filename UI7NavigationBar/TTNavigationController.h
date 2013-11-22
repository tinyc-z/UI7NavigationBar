//
//  TTNavigationController.h
//  Demo
//
//  Created by iBcker on 13-11-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UI7NavBarSytle)
{
    UI7NavBarSytleLight, //0.4 alpha
    UI7NavBarSytleDark, //0.8 alpha
    UI7NavBarSytleBlack, //1.0
};

@interface TTNavigationController : UINavigationController

- (void)setNavBarBgWithImage:(UIImage *)image;
- (void)setNavBarBgWithColor:(UIColor *)cl;
- (void)setNavBarStyle:(UI7NavBarSytle)style;

@end
