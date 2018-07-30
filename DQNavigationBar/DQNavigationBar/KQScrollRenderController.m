//
//  KQScrollRenderController.m
//  KQCloudService
//
//  Created by DaiQiao on 15/11/20.
//  Copyright © 2015年 DaiQiao. All rights reserved.
//

#import "KQScrollRenderController.h"
@interface KQScrollRenderController ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak)   UIView                 *scrollableView;
@property (assign, nonatomic) float                  lastContentOffset;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIView                 *overlay;
@property (assign, nonatomic) BOOL                   isCollapsed;
@property (assign, nonatomic) BOOL                   isExpanded;
@end

@implementation KQScrollRenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)followScrollView:(UIView *)scrollableView {
    self.scrollableView = scrollableView;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.panGesture setMaximumNumberOfTouches:1];
    
    [self.panGesture setDelegate:self];
    [self.scrollableView addGestureRecognizer:self.panGesture];
    
    /* The navbar fadeout is achieved using an overlay view with the same barTintColor.
     this might be improved by adjusting the alpha component of every navbar child */
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin = CGPointZero;
    self.overlay = [[UIView alloc] initWithFrame:frame];
    if ([self isIOS7]) {
        if (self.navigationController.navigationBar.barTintColor) {
            [self.overlay setBackgroundColor:self.navigationController.navigationBar.barTintColor];
        }
    }
    
    [self.overlay setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar addSubview:self.overlay];
    [self.overlay setAlpha:0];
    return;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    CGPoint translation = [gesture translationInView:[self.scrollableView superview]];
    
    float delta = self.lastContentOffset - translation.y;
    self.lastContentOffset = translation.y;
    CGRect frame;
    
    if (delta > 0) {
        if (self.isCollapsed) {
            return;
        }
        
        frame = self.navigationController.navigationBar.frame;
        if (frame.origin.y - delta < -24) {
            delta = frame.origin.y + 24;
        }
        
        frame.origin.y = MAX(-24, frame.origin.y - delta);
        self.navigationController.navigationBar.frame = frame;
        if (frame.origin.y == -24) {
            self.isCollapsed = YES;
            self.isExpanded = NO;
        }
        
        [self updateSizingWithDelta:delta];
        
        // Keeps the view's scroll position steady until the navbar is gone
        if ([self.scrollableView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self.scrollableView;
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,
                                                     scrollView.contentOffset.y - delta)];
        }
    }
    
    if (delta < 0) {
        if (self.isExpanded) {
            return;
        }
        
        frame = self.navigationController.navigationBar.frame;
        if (frame.origin.y - delta > 20) {
            delta = frame.origin.y - 20;
        }
        frame.origin.y = MIN(20, frame.origin.y - delta);
        self.navigationController.navigationBar.frame = frame;
        if (frame.origin.y == 20) {
            self.isExpanded = YES;
            self.isCollapsed = NO;
        }
        
        [self updateSizingWithDelta:delta];
    }
    
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.lastContentOffset = 0;
        [self checkForPartialScroll];
    }
    return;
}
- (void)checkForPartialScroll {
    CGFloat pos = self.navigationController.navigationBar.frame.origin.y;
    
    // Get back down
    if (pos >= -2) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame;
            frame = self.navigationController.navigationBar.frame;
            CGFloat delta = frame.origin.y - 20;
            frame.origin.y = MIN(20, frame.origin.y - delta);
            self.navigationController.navigationBar.frame = frame;
            
            self.isExpanded = YES;
            self.isCollapsed = NO;
            [self updateSizingWithDelta:delta];
        }];
    } else {
        // And back up
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame;
            frame = self.navigationController.navigationBar.frame;
            CGFloat delta = frame.origin.y + 24;
            frame.origin.y = MAX(-24, frame.origin.y - delta);
            self.navigationController.navigationBar.frame = frame;
            
            self.isExpanded = NO;
            self.isCollapsed = YES;
            [self updateSizingWithDelta:delta];
        }];
    }
    return;
}
- (void)updateSizingWithDelta:(CGFloat)delta {
    CGRect frame = self.navigationController.navigationBar.frame;
    
    float alpha = (frame.origin.y + 24) / frame.size.height;
    [self.overlay setAlpha:1 - alpha];
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor
                                                         colorWithAlphaComponent:alpha];
    
    frame = self.scrollableView.superview.frame;
    
    frame.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frame.origin.y += self.navigationController.navigationBar.frame.size.height;
    
    // 判断是否是ios7及其以上版本
    if (![self isIOS7]) {
        frame.origin.y =  self.navigationController.navigationBar.frame.origin.y - 20;
    }
    frame.size.height = frame.size.height + delta;
    self.scrollableView.superview.frame = frame;
    
    // Changing the layer's frame avoids UIWebView's glitchiness
    frame = self.scrollableView.layer.frame;
    frame.size.height += delta;
    self.scrollableView.layer.frame = frame;
    return;
}
- (BOOL)isIOS7 {
    return ([UIDevice currentDevice].systemVersion.integerValue >= 7) ? YES : NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
