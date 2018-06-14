//
//  BaseService.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

- (void)loadDataWithURL:(NSURL *)requestURL quearyParams:(NSDictionary *)quearyParams
             completion:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;

- (void)cancelLoad;

@end
