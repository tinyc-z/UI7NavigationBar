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

static const char *__wantsFullScreenLayout__ = "__wantsFullScreenLayout__";

- (BOOL)wantsFullScreenLayout
{
    id v=objc_getAssociatedObject(self,__wantsFullScreenLayout__);
    if (v!=nil) {
        return [v boolValue];
    }else{
        return YES;
    }
}

- (void)setWantsFullScreenLayout:(BOOL)b
{
    objc_setAssociatedObject(self, __wantsFullScreenLayout__, @(b), OBJC_ASSOCIATION_ASSIGN);
}

static const char *__automaticallyAdjustsScrollViewInsets__ = "__automaticallyAdjustsScrollViewInsets__";

- (BOOL)automaticallyAdjustsScrollViewInsets
{
    id v=objc_getAssociatedObject(self,__automaticallyAdjustsScrollViewInsets__);
    if (v!=nil) {
        return [v boolValue];
    }else{
        return NO;
    }
}

- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)b
{
    objc_setAssociatedObject(self, __automaticallyAdjustsScrollViewInsets__, @(b), OBJC_ASSOCIATION_ASSIGN);
}


static const char *__edgesForExtendedLayout__ = "__edgesForExtendedLayout__";

- (UIRectEdge)edgesForExtendedLayout
{
    id v=objc_getAssociatedObject(self,__edgesForExtendedLayout__);
    if (v!=nil) {
        return [v integerValue];
    }else{
        return UIRectEdgeAll;
    }
}

- (void)setEdgesForExtendedLayout:(UIRectEdge)rect
{
    objc_setAssociatedObject(self, __edgesForExtendedLayout__, @(rect), OBJC_ASSOCIATION_ASSIGN);
}

@end
