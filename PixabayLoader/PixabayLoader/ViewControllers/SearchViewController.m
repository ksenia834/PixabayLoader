//
//  ViewController.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "SearchViewController.h"
#import "ImageProvider.h"
#import "SearchResultCollectionViewCell.h"
#import "ImageModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageDetailsViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "SVProgressHUD.h"

@interface SearchViewController ()

@property(nonatomic, strong) ImageProvider  *loader;
@property(nonatomic, strong) NSArray        *models;

@property (weak, nonatomic) IBOutlet UISearchBar      *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, assign) UIEdgeInsets             collectionViewInsent;

@end

@implementation SearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTitles];
    [self setupAppearence];
    [self setupLoadData];

    [self loadDataWithSearchTerm: @"apple"];
}

#pragma mark - Setup Titles and Appeanrence

- (void)setupTitles {
    self.title = NSLocalizedString(@"SearchViewController.Title", "");
}

- (void)setupAppearence {
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.collectionViewInsent               = UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: SearchResultCollectionViewCell.defaultReuseIdentifier forIndexPath:indexPath];
    
    ImageModel *model = self.models[indexPath.row];
    
    [cell.thumbnailImageView sd_setImageWithURL: model.thumbnailURL placeholderImage: nil];
    cell.authorLabel.text = model.userName;

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb                = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageDetailsViewController *vc  = [sb instantiateViewControllerWithIdentifier: @"ImageDetailsViewController"];
    ImageModel *model               = self.models[indexPath.row];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:true];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.collectionViewInsent;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat cellHeight = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 300 : 150;
    return CGSizeMake(CGRectGetWidth(collectionView.frame) / 2 - (self.collectionViewInsent.left + self.collectionViewInsent.right), cellHeight);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self loadDataWithSearchTerm: searchBar.text];
    [self clearSearchBar];
}

#pragma mark - Load Data

- (void)setupLoadData {
    self.loader = [ImageProvider new];
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf.loader loadNext];
    }];
    
    self.collectionView.infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
}

- (void)loadDataWithSearchTerm:(NSString *)term {
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [self.loader initialLoad: term completion:^(NSArray *models, NSError * _Nullable error) {
        if (error) {
            [weakSelf showErrorMessage: error.localizedDescription];
        } else {
            weakSelf.models = models;
            [weakSelf.collectionView reloadData];
        }
        [SVProgressHUD dismiss];
        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
    }];
}

#pragma mark - Help mathods

- (void)clearSearchBar {
    self.searchBar.text = @"";
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize: size withTransitionCoordinator: coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    } completion: nil];
}
@end
