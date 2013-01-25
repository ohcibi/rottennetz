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

// gives is methods isExecuting and isFinished for use in the OperationQueue
@synthesize isExecuting = _isExecuting;
@synthesize isFinished = _isFinished;

-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super init];
    if (self) {
        self.jsonRequest = request;
        self.request = [NSMutableURLRequest requestWithURL:self.jsonRequest.url];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        _isExecuting = NO;
        _isFinished = NO;
    }
    return self;
}

-(void)start {
    if (![NSThread isMainThread]) {
        //NSURLConnection must perform in the main thread
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }
    
    self.isExecuting = YES;
    
    _response = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    
    if (nil == _connection) {
        [self finish];
    } else {
        [_connection start];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}
-(void)finish {
    self.isExecuting = NO;
    self.isFinished = YES;
}
-(void)setIsExecuting:(BOOL)isExecuting {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}
-(void)setIsFinished:(BOOL)isFinished {
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
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
    [self finish];
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
    
    [self finish];
}

@end
