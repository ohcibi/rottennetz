//
//  KeilerOperation.h
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRequest.h"

@interface KeilerHTTPOperation : NSOperation <NSURLConnectionDataDelegate> {
    BOOL _isExecuting;
    BOOL _isFinished;
    int _statusCode;
    NSURLConnection * _connection;
    NSMutableURLRequest * _request;
    NSMutableData * _response;
    JSONRequest * _jsonRequest;
}

-(id)initWithJSONRequest:(JSONRequest *)request;

@property(nonatomic) BOOL isExecuting;
@property(nonatomic) BOOL isFinished;
@property(nonatomic, strong)NSMutableURLRequest * request;
@property(nonatomic, strong)JSONRequest * jsonRequest;

@end
