//
//  UIApplication+UI7.m
//  Demo
//
//  Created by iBcker on 13-11-22.
//  Copyright (c) 2013年 iBcker. All rights reserved.
//

#import "UIApplication+UI7.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define _IOS_VERSION_UI7 ([[[UIDevice currentDevice] systemVersion] floatValue])

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_3
#error UI7NavigationBar doesn't support Deployement Target version < 4.3
#endif

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
