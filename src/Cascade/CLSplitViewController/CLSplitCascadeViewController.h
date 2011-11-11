//
//  CLSplitCascadeViewController.h
//  Cascade
//
//  Created by Emil Wojtaszek on 11-03-27.
//  Copyright 2011 CreativeLabs.pl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLCategoriesViewController;
@class CLCascadeNavigationController;
@class CLSplitCascadeView;

@interface CLSplitCascadeViewController : UIViewController {
    CLCategoriesViewController*     _categoriesViewController;
    CLCascadeNavigationController*  _cascadeNavigationController;
}

@property (nonatomic, strong) IBOutlet CLCategoriesViewController* categoriesViewController;
@property (nonatomic, strong) IBOutlet CLCascadeNavigationController* cascadeNavigationController;

- (void) setBackgroundView:(UIView*)backgroundView;
- (void) setDividerImage:(UIImage*)image;
- (void) presentModalControllerFromMiddle:(UIViewController*)controller;
- (void) dismissMiddleViewController;

@end
