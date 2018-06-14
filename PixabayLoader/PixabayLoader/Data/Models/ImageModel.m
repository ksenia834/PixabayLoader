//
//  ImageModel.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

- (id)copyWithZone:(nullable NSZone *)zone {
      ImageModel *modelCopy = [[self class] allocWithZone:zone];
    
    modelCopy.imageURL      = self.imageURL;
    modelCopy.thumbnailURL  = self.thumbnailURL;
    modelCopy.userName      = self.userName;
    modelCopy.tags          = self.tags;
    modelCopy.comments      = self.comments;
    modelCopy.favorites     = self.favorites;
    modelCopy.likes         = self.likes;
    modelCopy.views         = self.views;
    modelCopy.downloads     = self.downloads;
    modelCopy.imageWidth    = self.imageWidth;
    modelCopy.imageHeight   = self.imageHeight;

    return modelCopy;
}

@end
