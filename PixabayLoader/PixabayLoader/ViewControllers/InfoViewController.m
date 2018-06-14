//
//  InfoViewController.m
//  PixabayLoader
//
//  Created by Kseniia on 6/14/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "InfoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomeBackBarButtonItem.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView    *previewImageView;

@property (weak, nonatomic) IBOutlet UILabel        *resolutionLabel;
@property (weak, nonatomic) IBOutlet UILabel        *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel        *downloadsLabel;

@property (weak, nonatomic) IBOutlet UILabel        *resolutionInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel        *viewsInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel        *downloadsInfoLabel;

@end

@implementation InfoViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitles];
    [self setupAppearence];
    
    [self setupFromModel: self.model];
}

#pragma mark - Setup Titles and Appeanrence

- (void)setupAppearence {
    [self setupCustomeBackButton];
}

- (void)setupTitles {
    self.resolutionLabel.text = NSLocalizedString(@"InfoViewController.Resolution.Title", @"");
    self.viewsLabel.text = NSLocalizedString(@"InfoViewController.Views.Title", @"");
    self.downloadsLabel.text = NSLocalizedString(@"InfoViewController.Downloads.Title", @"");
}

#pragma mark - Fill Data

- (void)setupFromModel:(ImageModel *)model {
    [self.previewImageView sd_setImageWithURL: model.imageURL placeholderImage: nil];
    
    self.resolutionInfoLabel.text   = [NSString stringWithFormat:@"%@ x %@", @(model.imageWidth).stringValue, @(model.imageHeight).stringValue];
    self.viewsInfoLabel.text        = @(model.views).stringValue;
    self.downloadsInfoLabel.text    = @(model.downloads).stringValue;
    self.title                      = model.userName;
}

@end
