//
//  ImageProvider.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "ImageProvider.h"
#import "AFNetworking.h"
#import "API.h"
#import "ImageResponseParser.h"
#import "BaseService.h"

typedef void(^LoadCompletionBlock)(NSArray *models, NSError * _Nullable error);
static CGFloat const ItemsPerPageCount = 20;
static CGFloat const InitialPageNumbmer = 1;

@interface ImageProvider()

@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) BaseService         *dataLoader;
@property (nonatomic, strong) NSMutableArray      *models;
@property (nonatomic, assign) NSInteger           total;
@property (nonatomic, copy)   LoadCompletionBlock completionHandler;
@property (nonatomic, strong) NSString            *searchTerm;
@property (nonatomic, strong) NSURL               *baseURL;

@end

@implementation ImageProvider

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeSessionManager];
    }
    return self;
}

#pragma mark - Initial Setup

- (void)initializeSessionManager {
    self.dataLoader = [BaseService new];
    self.baseURL    = [NSURL URLWithString: PLImageProviderPath];
}

#pragma mark - Handlind Loading Data

- (void)initialLoad:(NSString *)searchTerm completion:(nullable void (^)(NSArray *models, NSError * _Nullable error))completionHandler {
    self.completionHandler  = completionHandler;
    self.searchTerm         = searchTerm;
    
    NSDictionary *params = [self queryDictionaryWithSearchTerm: searchTerm page: InitialPageNumbmer];
    NSURL *url = [NSURL URLWithString: PLImageProviderPath];
    [self.dataLoader loadDataWithURL: url quearyParams: params completion:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            ImageResponseParser *parser = [[ImageResponseParser alloc] initWithDictionary: responseObject];
            self.models = [[parser models] mutableCopy];
            self.total = [parser totalHitsCount];
            completionHandler(self.models, nil);
        }
    }];
}

- (void)loadNext {
    NSDictionary *params = [self queryDictionaryWithSearchTerm: self.searchTerm page: [self nextPage]];    
    [self.dataLoader loadDataWithURL: self.baseURL quearyParams: params completion:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            self.completionHandler(nil, error);
        } else {
            ImageResponseParser *parser = [[ImageResponseParser alloc] initWithDictionary: responseObject];
            NSArray *models = [parser models];
            [self.models addObjectsFromArray: models];
            self.completionHandler(self.models, nil);
        }
    }];
}

- (void)cancelLoad {
    [self.dataLoader cancelLoad];
}

- (NSDictionary *)queryDictionaryWithSearchTerm:(NSString *)searchTerm page:(NSInteger)page {
    return @{ @"q" : searchTerm, @"image_type" : @"photo", @"page" : @(page).stringValue, @"per_page" : @(ItemsPerPageCount).stringValue };
}

#pragma mark - Page calculation

- (NSInteger)currentPage {
    return self.models.count/ItemsPerPageCount;
}

- (NSInteger)nextPage {
    return [self currentPage] + 1;
}

@end
