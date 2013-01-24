//
//  ClientOperation.m
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "PostOperation.h"

@implementation PostOperation

-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super initWithJSONRequest:request];
    if (self) {
        NSString * length = [NSString stringWithFormat:@"%d", [self.jsonRequest.jsonData length]];
        [self.request setHTTPMethod:@"POST"];
        [self.request setValue:length forHTTPHeaderField:@"Content-Length"];
        [self.request setHTTPBody:self.jsonRequest.jsonData];
    }
    return self;
}

@end
