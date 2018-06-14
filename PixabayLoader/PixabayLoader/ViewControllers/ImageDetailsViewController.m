//
//  ImageDetailsViewController.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ImageDetailsViewController.h"
#import "ContentActionView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImagePreviewView.h"
#import "InfoViewController.h"
#import "CustomeBackBarButtonItem.h"

@interface ImageDetailsViewController ()

@property (weak, nonatomic) IBOutlet ContentActionView  *likesActionView;
@property (weak, nonatomic) IBOutlet ContentActionView  *favoritesActionView;
@property (weak, nonatomic) IBOutlet ContentActionView  *commentsActionView;
@property (weak, nonatomic) IBOutlet UILabel            *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel            *tagsLabel;
@property (weak, nonatomic) IBOutlet UIView             *infoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet ImagePreviewView   *imagePreviewView;

@end

@implementation ImageDetailsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupGestures];
    [self setupAppearence];
    [self setupFromModel: self.model];
}

#pragma mark - Setup Titles and Appeanrence

- (void)setupAppearence {
    [self setupCustomeBackButton];
    
    UIBarButtonItem *infoButton = [[CustomeBackBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"info"] target:self action:@selector(viewImageInfo)];
    
    UIBarButtonItem *shareButton = [[CustomeBackBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"share"] target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[infoButton, shareButton];
}

- (void)setupFromModel:(ImageModel *)model {
    [self.imagePreviewView.imageView sd_setImageWithURL: model.imageURL placeholderImage: nil];
    
    self.authorNameLabel.text = model.userName;
    self.tagsLabel.text       = model.tags;

    [self.likesActionView setActionImage: [UIImage imageNamed:@"heart"]];
    [self.favoritesActionView setActionImage: [UIImage imageNamed:@"star"]];
    [self.commentsActionView setActionImage: [UIImage imageNamed:@"comment"]];

    [self.likesActionView setActionInfoText: @(model.likes).stringValue];
    [self.favoritesActionView setActionInfoText: @(model.favorites).stringValue];
    [self.commentsActionView setActionInfoText: @(model.comments).stringValue];
}

#pragma mark - Setup and Handle Gestures

- (void)setupGestures {
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:gesRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self.infoView setHidden: !self.infoView.isHidden];
    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;

    if (!self.infoView.isHidden) {
        self.imageViewBottomConstraint.constant = 0;
    } else {
        self.imageViewBottomConstraint.constant = -CGRectGetHeight(self.infoView.frame);
    }
}

#pragma mark - BarButtons Actions

- (void)viewImageInfo {
    UIStoryboard *sb                = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InfoViewController *vc          = [sb instantiateViewControllerWithIdentifier: @"InfoViewController"];
    vc.model = [self.model copy];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)share {
    NSArray *objectsToShare = @[self.model.imageURL];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
