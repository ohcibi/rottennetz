//
//  KeilerPoster.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerPoster.h"

@implementation KeilerPoster
@synthesize delegate;
@synthesize success;
@synthesize error;

-(id)initWithDelegate:(id)myDelegate andSuccess:(SEL)mySuccess andError:(SEL)myError {
    self = [super init];
    if (self) {
        self.delegate = myDelegate;
        self.success = mySuccess;
        self.error = myError;
    }
    return self;
}

-(void)dealloc {
    self.delegate = nil;
}

-(BOOL)startRequestForURL:(NSString *)strUrl andDictionary:(NSDictionary *)dict {
    NSURL * url = [NSURL URLWithString:strUrl];
    NSData * data = [self JSONDataFromDict:dict];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString * length = [NSString stringWithFormat:@"%d", [data length]];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:data];
    
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    
    if (!connection) {
        return NO;
    } else {
        response = [NSMutableData data];
        return YES;
    }
}

-(NSData *)JSONDataFromDict:(NSDictionary *)dict {
    NSError * jsonError;
    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&jsonError];
    return data;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)myResponse {
    [response setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [response appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)myError {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.delegate performSelector:self.error withObject:myError];
#pragma clang diagnostic pop
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSError * jsonError;
    NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:response
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonError];
    [self.delegate performSelector:self.success withObject:jsonResponse];
#pragma clang diagnostic pop
}

@end
