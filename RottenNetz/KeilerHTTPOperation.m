//
//  KeilerOperation.m
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerHTTPOperation.h"

@implementation KeilerHTTPOperation
@synthesize request = _request;
@synthesize jsonRequest = _jsonRequest;

-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super init];
    if (self) {
        _response = [[NSMutableData alloc] init];
        
        self.jsonRequest = request;
        
        self.request = [NSMutableURLRequest requestWithURL:self.jsonRequest.url];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

-(void)main {
    _connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    [_connection start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse * http_response = (NSHTTPURLResponse *) response;
    _statusCode = [http_response statusCode];
    [_response setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_response appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSDictionary * response = [NSDictionary dictionaryWithObjectsAndKeys:@"Der Server ist nicht erreichbar. Bitte überprüfe die Konfiguration in den Einstellungen", @"message", nil];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.jsonRequest.delegate performSelector:self.jsonRequest.error withObject:response];
#pragma clang diagnostic pop
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError * jsonError;
    NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:_response
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonError];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (_statusCode < 400) {
        [self.jsonRequest.delegate performSelector:self.jsonRequest.success withObject:jsonResponse];
    } else {
        [self.jsonRequest.delegate performSelector:self.jsonRequest.error withObject:jsonResponse];
    }
#pragma clang diagnostic pop
}

@end
