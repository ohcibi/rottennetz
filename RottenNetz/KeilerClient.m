//
//  KeilerPoster.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerClient.h"
#import "PostOperation.h"
#import "GetOperation.h"

@implementation KeilerClient
@synthesize queue = _queue;

static KeilerClient * _sharedClient = nil;

+(KeilerClient *)sharedClient {
    if (_sharedClient == nil) {
        _sharedClient = [[self alloc] init];
    }
    
    return _sharedClient;
}
-(KeilerClient *)init {
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

-(void)startPOSTRequest:(JSONRequest *)request {
    PostOperation * operation = [[PostOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}
-(void)startGETRequest:(JSONRequest *)request {
    GetOperation * operation = [[GetOperation alloc] initWithJSONRequest:request];
    [self.queue addOperation:operation];
}

@end
