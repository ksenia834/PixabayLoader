//
//  BaseViewController.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)setupCustomeBackButton;
- (void)showErrorMessage:(NSString *)errorMessage;

@end
