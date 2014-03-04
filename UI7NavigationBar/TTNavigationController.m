//
//  TTNavigationController.m
//  Demo
//
//  Created by iBcker on 13-11-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import "TTNavigationController.h"
#import "UIApplication+UI7.h"

@interface TTNavigationController ()
@property (nonatomic,strong)UIImageView *navColorOverly;
@end

@implementation TTNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.opaque = NO;
    if (kCFCoreFoundationVersionNumber>=kCFCoreFoundationVersionNumber_iOS_5_0) {
        NSArray *vs=[self.navigationBar subviews];
        Class clazz;
        if (kCFCoreFoundationVersionNumber>=kCFCoreFoundationVersionNumber_iOS_6_0) {
            clazz=NSClassFromString(@"_UINavigationBarBackground");
        }else{
            clazz=NSClassFromString(@"UINavigationBarBackground");
        }
        for (UIView *v in vs) {
            if ([v isKindOfClass:clazz]) {
                v.hidden=YES;
                break;
            }
        }
    }
    [self setNavBarStyle:UI7NavBarSytleDark];
    [self.navigationBar insertSubview:_navColorOverly atIndex:0];
}



- (UIImageView *)navColorOverly
{
    if (!_navColorOverly) {
        if (!_navColorOverly) {
            _navColorOverly=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height+20)];
            _navColorOverly.frame=CGRectMake(0, -20, self.navigationBar.frame.size.width, 64);
        }
    }
    return _navColorOverly;
}

- (void)setNavBarStyle:(UI7NavBarSytle)style
{
    switch (style) {
        case UI7NavBarSytleLight:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
            break;
        case UI7NavBarSytleBlack:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
            break;
        default: //UI7NavBarSytleDark:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
            break;
    }
}

- (void)setNavBarBgWithColor:(UIColor *)cl
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    [cl set];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.navColorOverly.image=[image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

- (void)setNavBarBgWithImage:(UIImage *)image
{
    self.navColorOverly.image=image;
}

@end
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {}
@end
