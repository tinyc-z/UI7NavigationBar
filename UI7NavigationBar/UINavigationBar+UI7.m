//
//  UINavigationBar+UI7.m
//  UI7NavigationBar
//
//  Created by iBcker on 13-9-27.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import "UINavigationBar+UI7.h"
#import <objc/runtime.h>

#define _IOS_VERSION_UI7 ([[[UIDevice currentDevice] systemVersion] floatValue])

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_3
#error UI7NavigationBar doesn't support Deployement Target version < 5.0
#endif

@implementation UINavigationBar (UI7)

+ (void)injectUI7NavBar
{
    Method originMethod=class_getInstanceMethod(self, @selector(layoutSubviews));
    Method newMethod=class_getInstanceMethod(self, @selector(__layoutSubviews));
    
    method_exchangeImplementations(originMethod, newMethod);
}

static UIImageView *_navColorOverly=nil;

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
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    });

    if(_IOS_VERSION_UI7<7){
        static UIView *statusBackground=nil;
        if (!statusBackground) {
            NSArray *vs=[[[UIApplication sharedApplication] valueForKey:@"_statusBar"] subviews];
            for (UIView *v in vs) {
                if ([v isKindOfClass:NSClassFromString(@"UIStatusBarBackgroundView")]) {
                    statusBackground=v;
                    break;
                }
            }
        }
        [statusBackground setAlpha:0];
    }
    [self sendSubviewToBack:[self navColorOverly]];
}


- (UIImageView *)navColorOverly
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _navColorOverly=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+20)];
        _navColorOverly.frame=CGRectMake(0, -20, self.frame.size.width, 64);
        [self addSubview:_navColorOverly];
    });
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
