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

static KeilerClient * _sharedClient = nil;

+(KeilerClient *)sharedClient {
    if (_sharedClient == nil) {
        _sharedClient = [[self alloc] init];
    }
    
    return _sharedClient;
}

-(void)startPOSTRequest:(JSONRequest *)request {
    PostOperation * operation = [[PostOperation alloc] initWithJSONRequest:request];
    [operation start];
}
-(void)startGETRequest:(JSONRequest *)request {
    GetOperation * operation = [[GetOperation alloc] initWithJSONRequest:request];
    [operation start];
}

@end
