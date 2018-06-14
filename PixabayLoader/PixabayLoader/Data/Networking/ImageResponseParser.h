//
//  ImageResponseParser.h
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageResponseParser : NSObject

- (instancetype)initWithDictionary: (NSDictionary *)response;

- (NSArray *)models;
- (NSInteger)totalHitsCount;
@end
