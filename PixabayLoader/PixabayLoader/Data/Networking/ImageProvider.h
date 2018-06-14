//
//  ImageProvider.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageProvider : NSObject

- (void)initialLoad:(NSString *)searchTerm completion:(nullable void (^)(NSArray *models, NSError * _Nullable error))completionHandler;
- (void)loadNext;
- (void)cancelLoad;

@end
