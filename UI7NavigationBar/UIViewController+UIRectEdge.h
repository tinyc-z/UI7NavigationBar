//
//  UIViewController+UIRectEdge.h
//  SinaWeather
//
//  Created by iBcker on 13-10-28.
//
//  让 xocde4 能编译过

#import <UIKit/UIKit.h>

#ifndef __IPHONE_7_0
typedef NS_OPTIONS(NSUInteger, UIRectEdge) {
    UIRectEdgeNone   = 0,
    UIRectEdgeTop    = 1 << 0,
    UIRectEdgeLeft   = 1 << 1,
    UIRectEdgeBottom = 1 << 2,
    UIRectEdgeRight  = 1 << 3,
    UIRectEdgeAll    = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight
};
#endif

@interface UIViewController (UIRectEdge)

//#ifndef __IPHONE_7_0
- (BOOL)automaticallyAdjustsScrollViewInsets;
- (void)setAutomaticallyAdjustsScrollViewInsets:(BOOL)b;
- (UIRectEdge)edgesForExtendedLayout;
- (void)setEdgesForExtendedLayout:(UIRectEdge)rect;
//#endif
@end
