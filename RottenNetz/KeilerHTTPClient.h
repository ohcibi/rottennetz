//
//  KeilerPoster.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRequest.h"

@interface KeilerHTTPClient : NSObject {
    NSOperationQueue * _queue;
}

+(KeilerHTTPClient *)sharedClient;

-(void)startGETRequest:(JSONRequest *)request;
-(void)startPOSTRequest:(JSONRequest *)request;
-(void)startPUTRequest:(JSONRequest *)request;
-(void)startDELETERequest:(JSONRequest *)request;

@property(nonatomic, strong) NSOperationQueue * queue;
@end
