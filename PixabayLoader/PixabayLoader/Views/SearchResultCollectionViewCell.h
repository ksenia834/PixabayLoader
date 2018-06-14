//
//  SearchResultCollectionViewCell.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SearchResultCollectionViewCell: UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView    *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel        *authorLabel;

+ (NSString *)defaultReuseIdentifier;

@end
