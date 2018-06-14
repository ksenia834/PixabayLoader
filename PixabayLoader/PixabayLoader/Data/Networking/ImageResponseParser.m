//
//  ImageResponseParser.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ImageResponseParser.h"
#import "ImageModel.h"

@interface ImageResponseParser()

@property(nonatomic, strong) NSDictionary *response;
@end

@implementation ImageResponseParser

- (instancetype)initWithDictionary:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.response = response;
    }
    return self;
}

- (NSArray *)models {
    NSArray *hits = self.response[@"hits"];
    
    NSMutableArray *models = [NSMutableArray new];
    for (NSDictionary *dict in hits) {
        ImageModel *model = [ImageModel new];
        model.userName    = [dict valueForKey: @"user"];
        model.tags        = [dict valueForKey: @"tags"];
        model.comments    = [[dict objectForKey: @"comments"] integerValue];
        model.favorites   = [[dict objectForKey: @"favorites"] integerValue];
        model.likes       = [[dict objectForKey: @"likes"] integerValue];
        model.views       = [[dict objectForKey: @"views"] integerValue];
        model.downloads   = [[dict objectForKey: @"downloads"] integerValue];
        model.imageWidth   = [[dict objectForKey: @"imageWidth"] integerValue];
        model.imageHeight   = [[dict objectForKey: @"imageHeight"] integerValue];
        
        if ([dict objectForKey: @"largeImageURL"]) {
            NSString *imagePath = [dict objectForKey: @"largeImageURL"];
            model.imageURL  = [NSURL URLWithString: imagePath];
        }
        
        if ([dict objectForKey: @"previewURL"]) {
            NSString *imagePath = [dict objectForKey: @"previewURL"];
            model.thumbnailURL  = [NSURL URLWithString: imagePath];
        }

        [models addObject: model];
    }
    return models;
}

- (NSInteger)totalHitsCount {
    return [[self.response objectForKey: @"totalHits"] integerValue];
}

@end
