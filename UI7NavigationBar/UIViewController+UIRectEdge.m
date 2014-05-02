//
//  UIViewController+UIRectEdge.m
//  SinaWeather
//
//  Created by iBcker on 13-10-28.
//
//

#import "UIViewController+UIRectEdge.h"

#import <objc/runtime.h>

@implementation UIViewController (UIRectEdge)

static const char *kWantsFullScreenLayoutKey;

- (BOOL)wantsFullScreenLayout
{
    id v=objc_getAssociatedObject(self,&kWantsFullScreenLayoutKey);
    if (v!=nil) {
        return [v boolValue];
    }else{
        return YES;
    }
}

- (void)setWantsFullScreenLayout:(BOOL)b
{
    objc_setAssociatedObject(self, &kWantsFullScreenLayoutKey, @(b), OBJC_ASSOCIATION_ASSIGN);
}

static const char *kAutomaticallyAdjustsScrollViewInsetsKey;

- (BOOL)automaticallyAdjustsScrollViewInsets
{
    id v=objc_getAssociatedObject(self,&kAutomaticallyAdjustsScrollViewInsetsKey);
    if (v!=nil) {
        return [v boolValue];
    }else{
        return NO;
    }
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)b
{
    objc_setAssociatedObject(self, &kAutomaticallyAdjustsScrollViewInsetsKey, @(b), OBJC_ASSOCIATION_ASSIGN);
}


static const char *kEdgesForExtendedLayoutKey;

- (UIRectEdge)edgesForExtendedLayout
{
    id v=objc_getAssociatedObject(self,&kEdgesForExtendedLayoutKey);
    if (v!=nil) {
        return [v integerValue];
    }else{
        return UIRectEdgeAll;
    }
}

- (void)setEdgesForExtendedLayout:(UIRectEdge)rect
{
    objc_setAssociatedObject(self, &kEdgesForExtendedLayoutKey, @(rect), OBJC_ASSOCIATION_ASSIGN);
}

@end
