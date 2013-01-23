//
//  ClientOperation.h
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRequest.h"

@interface PostOperation : NSOperation <NSURLConnectionDataDelegate> {
    int _statusCode;
    NSURLConnection * _connection;
    NSMutableData * _response;
    JSONRequest * _request;
}

-(id)initWithJSONRequest:(JSONRequest *)request;

@property(nonatomic, strong)JSONRequest * request;
@end
