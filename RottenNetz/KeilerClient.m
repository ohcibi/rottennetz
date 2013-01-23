//
//  KeilerPoster.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerClient.h"
#import "PostOperation.h"

@implementation KeilerClient

static KeilerClient * _sharedClient = nil;

+(KeilerClient *)sharedClient {
    if (_sharedClient == nil) {
        _sharedClient = [[self alloc] init];
    }
    
    return _sharedClient;
}

-(void)startJSONRequest:(JSONRequest *)request {
    PostOperation * operation = [[PostOperation alloc] initWithJSONRequest:request];
    [operation start];
}

@end
