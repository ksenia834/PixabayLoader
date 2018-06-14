//
//  BaseService.m
//  PixabayLoader
//
//  Created by Kseniia on 6/7/18.
//  Copyright © 2018 Kseniia. All rights reserved.
//

#import "BaseService.h"
#import "AFNetworking.h"
#import "API.h"

@interface BaseService()

@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation BaseService

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeSessionManager];
    }
    return self;
}

- (void)dealloc {
    [self cancelLoad];
}

#pragma mark - Session Initialization

- (void)initializeSessionManager {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadRevalidatingCacheData;
    self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
}

#pragma mark - Load Data Mathods

- (void)cancelLoad {
    [self.dataTask cancel];
}

- (void)loadDataWithURL:(NSURL *)requestURL quearyParams:(NSDictionary *)quearyParams completion:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    [self cancelLoad];

    NSURLRequest *request   = [self requestWithURL: requestURL quearyParams: quearyParams];
    self.dataTask           = [self.manager dataTaskWithRequest:request uploadProgress: nil downloadProgress: nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completionHandler(response, responseObject, error);
    }];
    
    [self.dataTask resume];
}

- (NSURLRequest *)requestWithURL:(NSURL *)baseURL quearyParams:(NSDictionary *)params {
    NSURL *requestURL     = [self urlWithPath: baseURL parameters: params];
    NSURLRequest *request = [NSURLRequest requestWithURL: requestURL];
    return request;
}

- (NSURL *)urlWithPath:(NSURL *)url parameters:(NSDictionary *)params {
    NSURLComponents *urlCompnents = [NSURLComponents componentsWithURL: url resolvingAgainstBaseURL: false];
    NSMutableArray  *queryItems   = [urlCompnents.queryItems mutableCopy];
    
    for (NSString *key in params.allKeys) {
        NSURLQueryItem  *item = [[NSURLQueryItem alloc] initWithName:key value: params[key]];
        [queryItems addObject: item];
    }
    
    urlCompnents.queryItems = queryItems;
    return urlCompnents.URL;
}

@end

