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

-(id)initWithUrl:(NSString *)url delegate:(id)delegate success:(SEL)success andError:(SEL)error {
    NSDictionary * dict = [[NSDictionary alloc] init];
    return [self initWithUrl:url dictionary:dict delegate:delegate success:success andError:error];
}
-(id)initWithUrl:(NSString *)url dictionary:(NSDictionary *)dict delegate:(id)delegate success:(SEL)success andError:(SEL)error {
    self = [super init];
    if (self) {
        self.url = [self getURLFromString:url];
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
-(NSURL *)getURLFromString:(NSString *)strURL {
    NSString * urlRoot = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_root"];
    NSMutableString * fullUrl = [NSMutableString stringWithString:[urlRoot stringByAppendingString:strURL]];
    
    NSString * auth_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"];
    if (nil != auth_token) {
        NSString * query_token;
        if ([fullUrl rangeOfString:@"?"].location == NSNotFound) {
            query_token = [NSString stringWithFormat:@"?auth_token=%@", auth_token];
        } else {
            query_token = [NSString stringWithFormat:@"&auth_token=%@", auth_token];
        }
        [fullUrl appendString:query_token];
    }
    
    return [NSURL URLWithString:fullUrl];
}

@end
