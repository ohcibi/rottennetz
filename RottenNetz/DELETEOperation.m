//
//  DELETEOperation.m
//  RottenNetz
//
//  Created by ohcibi on 25.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "DELETEOperation.h"

@implementation DELETEOperation

-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super initWithJSONRequest:request];
    if (self) {
        [self.request setHTTPMethod:@"DELETE"];
    }
    return self;
}

@end
