//
//  UINavigationBar+UI7.m
//  UI7NavigationBar
//
//  Created by iBcker on 13-9-27.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import "UINavigationBar+UI7.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define _IOS_VERSION_UI7 ([[[UIDevice currentDevice] systemVersion] floatValue])

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_3
#error UI7NavigationBar doesn't support Deployement Target version < 4.3
#endif


@interface UIApplication (UI7)
+ (void)inject;
@end

@implementation UINavigationBar (UI7)

+ (void)injectUI7NavBar
{
    Method originMethod=class_getInstanceMethod(self, @selector(layoutSubviews));
    Method newMethod=class_getInstanceMethod(self, @selector(__layoutSubviews));
    
    method_exchangeImplementations(originMethod, newMethod);
    [UIApplication inject];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

-(void)__layoutSubviews
{
    [self __layoutSubviews];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContext(CGSizeMake(1, 1));
        [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] set];
        UIRectFill(CGRectMake(0, 0, 1, 1));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(_IOS_VERSION_UI7<5){
            self.layer.contents=(id)image.CGImage;
        }else{
            [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
        NSArray *vs=[self subviews];
        Class clazz=NSClassFromString(@"_UINavigationBarBackground");
        for (UIView *v in vs) {
            if ([v isKindOfClass:clazz]) {
                v.hidden=YES;
                break;
            }
        }
    });
    [self sendSubviewToBack:[self navColorOverly]];
    
}


static const char *navColorOverly = "navColorOverly";

- (UIImageView *)_navColorOverly {
    return (UIImageView *)objc_getAssociatedObject(self, navColorOverly);
}

- (void)_setNavColorOverly:(UIImageView *)Overly {
    objc_setAssociatedObject(self, navColorOverly, Overly, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)navColorOverly
{
    UIImageView *_navColorOverly=(UIImageView*)[self _navColorOverly];
    if (!_navColorOverly) {
        _navColorOverly=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+20)];
        _navColorOverly.frame=CGRectMake(0, -20, self.frame.size.width, 64);
        [self insertSubview:_navColorOverly atIndex:0];
        [self _setNavColorOverly:_navColorOverly];
    }
    return _navColorOverly;
}

static const char *navOverlyColor = "navOverlyColor";

- (UIColor *)navOverlyColor {
    return (UIColor *)objc_getAssociatedObject(self, navOverlyColor);
}

- (void)setNavOverlyColor:(UIColor *)cl {
    objc_setAssociatedObject(self, navOverlyColor, cl, OBJC_ASSOCIATION_RETAIN);
}

- (void)setConstomBackgroundAlpha:(float)f
{
    [self navColorOverly].alpha=f;
}

- (void)setConstomBackgroundColor:(UIColor *)cl
{
    [self setNavOverlyColor:cl];
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    [cl set];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self navColorOverly].image=[image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
}

@end

@implementation UIApplication (UI7)

+ (void)inject
{
    Method originMethod=class_getInstanceMethod(self, @selector(setStatusBarStyle:));
    Method newMethod=class_getInstanceMethod(self, @selector(__setStatusBarStyle:));
    
    method_exchangeImplementations(originMethod, newMethod);
    
    originMethod=class_getInstanceMethod(self, @selector(setStatusBarStyle:animated:));
    newMethod=class_getInstanceMethod(self, @selector(__setStatusBarStyle:animated:));
    
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)__setStatusBarStyle:(UIStatusBarStyle)style
{
    [self __setStatusBarStyle:style];
    if (style==UIStatusBarStyleBlackTranslucent) {
        [self hiddenStatusBarBackground:YES];
    }
}

-(void)__setStatusBarStyle:(UIStatusBarStyle)style animated:(BOOL)animated
{
    [self __setStatusBarStyle:style animated:animated];
    
    if (style==UIStatusBarStyleBlackTranslucent) {
        if (animated) {
            [self performSelector:@selector(hiddenStatusBarBackground:) withObject:@(YES) afterDelay:0.6];
        }else{
            [self hiddenStatusBarBackground:YES];
        }
    }
}

- (void)hiddenStatusBarBackground:(BOOL)hidden
{
    if(_IOS_VERSION_UI7<7){
        BOOL isStatusBarHidden=[[UIApplication sharedApplication] isStatusBarHidden];
        if (isStatusBarHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
        UIView *statusbar=[[UIApplication sharedApplication] valueForKey:@"_statusBar"];
        NSArray *vs=[statusbar subviews];
        for (UIView *v in vs) {
            if ([v isKindOfClass:NSClassFromString(@"UIStatusBarBackgroundView")]) {
                statusbar=v;
                break;
            }
        }
        if (isStatusBarHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }
        if (hidden) {
            [statusbar setHidden:YES];
        }else{
            [statusbar setHidden:NO];
        }
    }
}

@end


