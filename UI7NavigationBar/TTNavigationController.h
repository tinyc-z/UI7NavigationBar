//
//  TTNavigationController.h
//  Demo
//
//  Created by iBcker on 13-11-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTNavBarSytle)
{
    TTNavBarSytleLight, //0.4 alpha
    TTNavBarSytleDark, //0.8 alpha
    TTNavBarSytleBlack, //1.0
    TTNavBarSytleTransparent, //0.0 alpha
    TTNavBarSytleImage, //自定义图片
    TTNavBarSytleColor, //自定义色值
};

@interface TTNavigationController : UINavigationController
@property (nonatomic,assign)TTNavBarSytle navBarStyle;
@property (nonatomic,strong,readonly)UIImageView *navOverly;

- (void)setNavBarBgWithImage:(UIImage *)image;
- (void)setNavBarBgWithColor:(UIColor *)cl;
- (void)setNavBarBgWithColor:(UIColor *)cl animated:(BOOL)animated;
- (void)setNavBarStyle:(TTNavBarSytle)style;
- (void)setNavBarStyle:(TTNavBarSytle)style animated:(BOOL)animated;

@end
