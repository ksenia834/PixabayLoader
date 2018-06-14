//
//  ImageDetailsViewController.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
#import "BaseViewController.h"

@interface ImageDetailsViewController : BaseViewController

@property(nonatomic, strong) ImageModel  *model;

@end
