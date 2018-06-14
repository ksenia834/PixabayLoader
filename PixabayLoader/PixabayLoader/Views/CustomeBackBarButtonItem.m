//
//  CustomeBackBarButtonItem.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "CustomeBackBarButtonItem.h"

@implementation CustomeBackBarButtonItem

- (instancetype)initWithImage:(UIImage *)image target:(nullable id)target action:(nullable SEL)action {
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    [button setImage: image forState: UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:target action: action forControlEvents: UIControlEventTouchUpInside];
    [button setImageEdgeInsets: UIEdgeInsetsMake(0, -20, 0, 0)];

    if (@available(iOS 11.0, *)) {
        [button.widthAnchor constraintEqualToConstant: 40.0].active = YES;
        [button.heightAnchor constraintEqualToConstant: 40.0].active = YES;
    } else {
        button.frame = CGRectMake(0, 0, 40, 40);
    }
    
    self = [super initWithCustomView: button];
    return self;
}

@end
