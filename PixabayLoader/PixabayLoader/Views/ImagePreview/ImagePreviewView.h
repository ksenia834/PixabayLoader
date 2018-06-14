//
//  ImagePreviewView.h
//  PixabayLoader
//
//  Created by Kseniia on 6/14/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNibView.h"

@interface ImagePreviewView : BaseNibView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView         *view;

@end
