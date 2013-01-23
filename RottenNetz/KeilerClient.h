//
//  KeilerPoster.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONRequest.h"

@interface KeilerClient : NSObject

+(KeilerClient *)sharedClient;

-(void)startJSONRequest:(JSONRequest *)request;
@end
