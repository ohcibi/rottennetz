//
//  KeilerPoster.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#define MAX_ASYNC_REQUESTS 3

#import "KeilerHTTPClient.h"
#import "GETOperation.h"
#import "POSTOperation.h"
#import "PUTOperation.h"
#import "DELETEOperation.h"

@implementation KeilerHTTPClient

static KeilerHTTPClient * _sharedClient = nil;

+(KeilerHTTPClient *)sharedClient {
    if (_sharedClient == nil) {
        _sharedClient = [[self alloc] init];
    }
    
    return _sharedClient;
}
-(KeilerHTTPClient *)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
        
        _asyncQueue = [[NSOperationQueue alloc] init];
        _asyncQueue.maxConcurrentOperationCount = MAX_ASYNC_REQUESTS;
    }
    return self;
}

-(void)startGETRequest:(JSONRequest *)request {
    GETOperation * operation = [[GETOperation alloc] initWithJSONRequest:request];
    [_queue addOperation:operation];
}
-(void)startPOSTRequest:(JSONRequest *)request {
    POSTOperation * operation = [[POSTOperation alloc] initWithJSONRequest:request];
    [_queue addOperation:operation];
}
-(void)startPUTRequest:(JSONRequest *)request {
    PUTOperation * operation = [[PUTOperation alloc] initWithJSONRequest:request];
    [_queue addOperation:operation];
}
-(void)startDELETERequest:(JSONRequest *)request {
    DELETEOperation * operation = [[DELETEOperation alloc] initWithJSONRequest:request];
    [_queue addOperation:operation];
}

-(void)startAsyncOperationWithBlock:(void (^)(void))block {
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:block];
    [_asyncQueue addOperation:operation];
}

@end
