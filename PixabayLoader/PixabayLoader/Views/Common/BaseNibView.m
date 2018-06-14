//
//  BaseNibView.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "BaseNibView.h"

@implementation BaseNibView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup { }

- (UIView *)loadFromNib: (NSString *)nibName {
    NSBundle *bundle = [NSBundle mainBundle];
    UINib *nib       = [UINib nibWithNibName:nibName bundle: bundle];
    NSArray *array   = [nib instantiateWithOwner:self options: nil];
    return array.firstObject;
}

@end
