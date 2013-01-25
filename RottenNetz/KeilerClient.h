//
//  KeilerPoster.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRequest.h"

@interface KeilerClient : NSObject {
    NSOperationQueue * _queue;
}

+(KeilerClient *)sharedClient;

-(void)startPOSTRequest:(JSONRequest *)request;
-(void)startGETRequest:(JSONRequest *)request;

@property(nonatomic, strong) NSOperationQueue * queue;
@end
