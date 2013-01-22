//
//  KeilerPoster.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeilerPoster : NSObject <NSURLConnectionDataDelegate> {
    NSMutableData * response;
}

-(id)initWithDelegate:(id)delegate andSuccess:(SEL)success andError:(SEL)error;
-(BOOL)startRequestForURL:(NSString *)url andDictionary:(NSDictionary *)dict;
-(NSData *)JSONDataFromDict:(NSDictionary *)dict;
    
@property(nonatomic, retain) id delegate;
@property(nonatomic) SEL success;
@property(nonatomic) SEL error;
@end
