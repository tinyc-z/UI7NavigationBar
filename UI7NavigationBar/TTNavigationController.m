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
    CGFloat osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (osVersion>=5) {
        NSArray *vs=[self.navigationBar subviews];
        Class clazz;
        if ((int)osVersion==5) {
            clazz=NSClassFromString(@"UINavigationBarBackground");
        }else{
            clazz=NSClassFromString(@"_UINavigationBarBackground");
        }
        for (UIView *v in vs) {
            if ([v isKindOfClass:clazz]) {
                v.hidden=YES;
                break;
            }
        }
    }
    [self setNavBarStyle:TTNavBarSytleDark];
    [self.navigationBar insertSubview:self.navColorOverly atIndex:0];
}

- (UIImageView *)navOverly
{
    return _navColorOverly;
}

- (UIImageView *)navColorOverly
{
    if (!_navColorOverly) {
        if (!_navColorOverly) {
            _navColorOverly=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height+20)];
            _navColorOverly.frame=CGRectMake(0, -20, self.navigationBar.frame.size.width, 64);
            _navColorOverly.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        }
    }
    return _navColorOverly;
}
- (void)setNavBarStyle:(TTNavBarSytle)style animated:(BOOL)animated
{
    if (_navBarStyle==style) {
        return;
    }
    switch (style) {
        case TTNavBarSytleLight:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] animated:animated];
            break;
        case TTNavBarSytleBlack:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] animated:animated];
            break;
        case TTNavBarSytleTransparent:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] animated:animated];
            break;
        default: //TTNavBarSytleDark:
            [self setNavBarBgWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] animated:animated];
            break;
    }
    _navBarStyle=style;
}


- (void)setNavBarStyle:(TTNavBarSytle)style
{
    [self setNavBarStyle:style animated:NO];
}

- (void)setNavBarBgWithColor:(UIColor *)cl animated:(BOOL)animated
{
    _navBarStyle=TTNavBarSytleColor;
    [_navColorOverly.layer removeAnimationForKey:kCATransitionFade];
    if (animated) {
        CATransition *animate  = [CATransition animation];
        animate.type = kCATransitionFade;
        animate.duration = 0.3f;
        [_navColorOverly.layer addAnimation:animate forKey:kCATransitionFade];
    }
    UIGraphicsBeginImageContext(CGSizeMake(2, 2));
    [cl set];
    UIRectFill(CGRectMake(0, 0, 2, 2));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.navColorOverly.image=[image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

- (void)setNavBarBgWithColor:(UIColor *)cl
{
    [self setNavBarBgWithColor:cl animated:NO];
}

- (void)setNavBarBgWithImage:(UIImage *)image
{
    _navBarStyle=TTNavBarSytleImage;
    self.navColorOverly.image=image;
}

@end
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {}
@end
