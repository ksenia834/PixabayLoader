//
//  ContentActionView.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNibView.h"
@interface ContentActionView : BaseNibView

- (void)setActionImage:(UIImage *)image;
- (void)setActionInfoText:(NSString *)info;

@end
