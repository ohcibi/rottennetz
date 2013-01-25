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
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
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
    [[[UIAlertView alloc] initWithTitle:nil message:@"Der Server ist nicht erreichbar. Bitte überprüfe die Konfiguration in den Einstellungen" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
