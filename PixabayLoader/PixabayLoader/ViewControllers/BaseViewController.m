//
//  BaseViewController.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomeBackBarButtonItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)setupCustomeBackButton {
    self.navigationItem.backBarButtonItem = nil;
    
    UIBarButtonItem *backButtonItem = [[CustomeBackBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"backArrow"] target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)showErrorMessage:(NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Default.Error.Alert.Title", "")
                                                                   message: errorMessage
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle: NSLocalizedString(@"Default.Ok.Title", "")
                                                       style:UIAlertActionStyleDefault handler: nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
