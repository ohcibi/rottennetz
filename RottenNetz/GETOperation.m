//
//  GetOperation.m
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "GETOperation.h"

@implementation GETOperation
-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super initWithJSONRequest:request];
    if (self) {
        [self.request setHTTPMethod:@"GET"];
    }
    return self;
}
@end
