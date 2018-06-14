//
//  ImageModel.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel: NSObject <NSCopying>

@property(nonatomic, strong) NSURL      *imageURL;
@property(nonatomic, strong) NSURL      *thumbnailURL;
@property(nonatomic, strong) NSString   *userName;
@property(nonatomic, strong) NSString   *tags;
@property(nonatomic, assign) NSInteger  comments;
@property(nonatomic, assign) NSInteger  favorites;
@property(nonatomic, assign) NSInteger  likes;
@property(nonatomic, assign) NSInteger  views;
@property(nonatomic, assign) NSInteger  downloads;
@property(nonatomic, assign) NSInteger  imageWidth;
@property(nonatomic, assign) NSInteger  imageHeight;

@end
