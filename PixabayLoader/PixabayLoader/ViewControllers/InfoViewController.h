//
//  InfoViewController.h
//  PixabayLoader
//
//  Created by Kseniia on 6/14/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
#import "BaseViewController.h"


@interface InfoViewController : BaseViewController
@property(nonatomic, strong) ImageModel  *model;

@end
