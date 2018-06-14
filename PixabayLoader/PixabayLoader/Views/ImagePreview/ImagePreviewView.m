//
//  ImagePreviewView.m
//  PixabayLoader
//
//  Created by Kseniia on 6/14/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ImagePreviewView.h"
@interface ImagePreviewView() <UIGestureRecognizerDelegate> {
}

@end

@implementation ImagePreviewView

#pragma mark - Lifecycle

+ (Class)layerClass {
    return [CATiledLayer class];
}

- (void)setup {
    self.view           = [self loadFromNib: NSStringFromClass([ImagePreviewView class])];
    self.view.frame     = self.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self addSubview: self.view];
    
    [self setupGestureRecognizers];
    
    self.imageView.autoresizingMask     = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.scrollView.minimumZoomScale    = 1.0;
    self.scrollView.maximumZoomScale    = 100.0;
    self.scrollView.contentSize         = self.imageView.frame.size;
    
    self.scrollView.contentInset        = UIEdgeInsetsZero;
    self.scrollView.contentMode         = (UIViewContentModeScaleAspectFit);
}

#pragma mark - Setup Gesture Recognizers

- (void)setupGestureRecognizers {
    [self.imageView addGestureRecognizer: [self tapGestureRecognizer: 2 withDelegate: self]];
}

- (UITapGestureRecognizer *)tapGestureRecognizer: (int)numberOfTapsRequired withDelegate: (id<UIGestureRecognizerDelegate>) delegate {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action: @selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = numberOfTapsRequired;
    [tapGesture setDelegate: delegate];
    return tapGesture;
}

- (void)tapGesture: UITapGestureRecognizer {
    if ( self.scrollView.zoomScale > 1 ) {
        [self resetImageZoom];
    } else {
        [self zoomIn];
    }
}

#pragma mark - Setup Zooming

- (void)resetImageZoom {
    self.scrollView.zoomScale = 1.0;
}

- (void)zoomIn {
    self.scrollView.zoomScale = 20.0;
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return TRUE;
}

@end
