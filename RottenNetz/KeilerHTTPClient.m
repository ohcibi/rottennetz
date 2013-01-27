//
//  KeilerPoster.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerHTTPClient.h"
#import "GETOperation.h"
#import "POSTOperation.h"
#import "PUTOperation.h"
#import "DELETEOperation.h"

@implementation KeilerHTTPClient
@synthesize queue = _queue;

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
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

-(void)startGETRequest:(JSONRequest *)request {
    GETOperation * operation = [[GETOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}
-(void)startPOSTRequest:(JSONRequest *)request {
    POSTOperation * operation = [[POSTOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}
-(void)startPUTRequest:(JSONRequest *)request {
    PUTOperation * operation = [[PUTOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}
-(void)startDELETERequest:(JSONRequest *)request {
    DELETEOperation * operation = [[DELETEOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}

@end
