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
        NSString * urlRoot = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_root"];
        self.url = [NSURL URLWithString:[urlRoot stringByAppendingString:url]];
        self.jsonData = [self jsonDataFromDictionary:dict];
        self.delegate = delegate;
        self.success = success;
        self.error = error;
    }
    return self;
}
-(NSData *)jsonDataFromDictionary:(NSDictionary *)dict {
    NSMutableDictionary * theDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSString * auth_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"];
    if (nil != auth_token) {
        [theDict setObject:auth_token forKey:@"auth_token"];
    }
    
    NSError * jsonError;
    return [NSJSONSerialization dataWithJSONObject:theDict options:0 error:&jsonError];
}

@end
