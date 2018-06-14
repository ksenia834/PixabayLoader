//
//  ContentActionView.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ContentActionView.h"

@interface ContentActionView()

@property (weak, nonatomic) IBOutlet UIImageView    *actionImageView;
@property (weak, nonatomic) IBOutlet UILabel        *actionInfoLabel;
@property (weak, nonatomic) IBOutlet UIView         *view;

@end

@implementation ContentActionView

- (void)setup {
    self.view           = [self loadFromNib: NSStringFromClass([ContentActionView class])];
    self.view.frame     = self.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview: self.view];
}

- (void)setActionImage:(UIImage *)image {
    self.actionImageView.image = image;
}

- (void)setActionInfoText:(NSString *)info {
    self.actionInfoLabel.text = info;
}

@end
