//
//  KeilerRequest.m
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "JSONRequest.h"

@implementation JSONRequest
@synthesize url = _url;
@synthesize jsonData = _jsonData;
@synthesize delegate = _delegate;
@synthesize success = _success;
@synthesize error = _error;
-(id)initWithUrl:(NSString *)url dictionary:(NSDictionary *)dict delegate:(id)delegate success:(SEL)success andError:(SEL)error {
    self = [super init];
    if (self) {
        self.url = [NSURL URLWithString:url];
        self.jsonData = [self jsonDataFromDictionary:dict];
        self.delegate = delegate;
        self.success = success;
        self.error = error;
    }
    return self;
    
}
-(NSData *)jsonDataFromDictionary:(NSDictionary *)dict {
    NSError * jsonError;
    return [NSJSONSerialization dataWithJSONObject:dict options:0 error:&jsonError];
}

@end
