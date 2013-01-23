//
//  ClientOperation.m
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "PostOperation.h"

@implementation PostOperation
@synthesize request = _request;

-(id)initWithJSONRequest:(JSONRequest *)request {
    self = [super init];
    if (self) {
        self.request = request;
        _response = [[NSMutableData alloc] init];
        [self initConnection];
    }
    return self;
}

-(void)initConnection {
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:self.request.url];
    NSString * length = [NSString stringWithFormat:@"%d", [self.request.jsonData length]];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:length forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:self.request.jsonData];
    
    _connection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

-(void)main {
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
    [self.request.delegate performSelector:self.request.error withObject:response];
#pragma clang diagnostic pop
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError * jsonError;
    NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:_response
                                                              options:NSJSONReadingMutableContainers
                                                                error:&jsonError];
    int succ = [[jsonResponse objectForKey:@"success"] integerValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (succ == 1) {
        [self.request.delegate performSelector:self.request.success withObject:jsonResponse];
    } else {
        [self.request.delegate performSelector:self.request.error withObject:jsonResponse];
    }
#pragma clang diagnostic pop
}

@end
