//
//  CLSegmentedView.m
//  Cascade
//
//  Created by Emil Wojtaszek on 11-04-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CLSegmentedView.h"

@interface CLSegmentedView (Private)
- (void) setupViews;
- (void) updateRoundedCorners;
@end

@implementation CLSegmentedView

@synthesize footerView = _footerView;
@synthesize headerView = _headerView;
@synthesize contentView = _contentView;
@synthesize viewSize = _viewSize;
@synthesize showRoundedCorners = _showRoundedCorners;
@synthesize rectCorner = _rectCorner;

#pragma mark - Init & dealloc

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init
{
    self = [super init];
    if (self) {

        _roundedCornersView = [[UIView alloc] init];
        [_roundedCornersView setBackgroundColor: [UIColor clearColor]];
        [self addSubview: _roundedCornersView];
        
        _viewSize = CLViewSizeNormal;
        _rectCorner = UIRectCornerAllCorners;
        _showRoundedCorners = NO;
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithSize:(CLViewSize)size {
    self = [self init];
    if (self) {
        _viewSize = size;
    }
    return self;
}


#pragma mark -
#pragma mark Setters

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setContentView:(UIView*)contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];

        _contentView = contentView;

        if (_contentView) {
            if (_headerView)
                [_roundedCornersView insertSubview:_contentView belowSubview:_headerView];
            else
                [_roundedCornersView addSubview: _contentView];
            
            [self setNeedsLayout];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setHeaderView:(UIView*)headerView {
    
    if (_headerView != headerView) {
        [_headerView removeFromSuperview];
        
        _headerView = headerView;

        if (_headerView) {
            [_headerView setAutoresizingMask:
             UIViewAutoresizingFlexibleLeftMargin | 
             UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleTopMargin];
            [_headerView setUserInteractionEnabled:YES];
            
            if (_contentView)
                [_roundedCornersView insertSubview:_headerView aboveSubview:_contentView];
            else
                [_roundedCornersView addSubview: _headerView];
            [self setNeedsLayout];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setFooterView:(UIView*)footerView {
    
    if (_footerView != footerView) {
        [_footerView removeFromSuperview];
        
        _footerView = footerView;
        if (_footerView) {
            [_footerView setAutoresizingMask:
             UIViewAutoresizingFlexibleLeftMargin | 
             UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleBottomMargin];
            [_footerView setUserInteractionEnabled:YES];
            
            if (_contentView)
                [_roundedCornersView insertSubview:_footerView aboveSubview:_contentView];
            else
                [_roundedCornersView addSubview: _footerView];
            [self setNeedsLayout];
        }
    }
}





#pragma mark -
#pragma mark Private

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) updateRoundedCorners {
    
    if (_showRoundedCorners) {
        CGRect toolbarBounds = self.bounds;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect: toolbarBounds
                                                   byRoundingCorners:_rectCorner
                                                         cornerRadii:CGSizeMake(6.0f, 6.0f)];
        [maskLayer setPath:[path CGPath]];
        
        _roundedCornersView.layer.masksToBounds = YES;
        _roundedCornersView.layer.mask = maskLayer;
    } 
    else {
        _roundedCornersView.layer.masksToBounds = NO;
        [_roundedCornersView.layer setMask: nil];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) layoutSubviews {

    CGRect rect = self.bounds;
    
    CGFloat viewWidth = rect.size.width;
    CGFloat viewHeight = rect.size.height;
    CGFloat headerHeight = 0.0;
    CGFloat footerHeight = 0.0;
    
    _roundedCornersView.frame = rect;
    
    if (_headerView) {
        headerHeight = _headerView.frame.size.height;
        
        CGRect newHeaderViewFrame = CGRectMake(0.0, 0.0, viewWidth, headerHeight);
        [_headerView setFrame: newHeaderViewFrame];
    }
    
    if (_footerView) {
        footerHeight = _footerView.frame.size.height;
        CGFloat footerY = viewHeight - footerHeight;
        
        CGRect newFooterViewFrame = CGRectMake(0.0, footerY, viewWidth, footerHeight);
        [_footerView setFrame: newFooterViewFrame];
    }
    
    [_contentView setFrame: CGRectMake(0.0, headerHeight, viewWidth, viewHeight - headerHeight - footerHeight)];

    [self updateRoundedCorners];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    _footerView = nil;
    _headerView = nil;
    _contentView = nil;
    _roundedCornersView = nil;

}

#pragma mark
#pragma mark Setters

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setRectCorner:(UIRectCorner)corners {
    if (corners != _rectCorner) {
        _rectCorner = corners;
        [self setNeedsLayout];
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setShowRoundedCorners:(BOOL)show {
    if (show != _showRoundedCorners) {
        _showRoundedCorners = show;
        [self setNeedsLayout];
    }
}


@end
