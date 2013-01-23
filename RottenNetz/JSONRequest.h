//
//  KeilerRequest.h
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONRequest : NSObject {
    NSURL * _url;
    NSData * _jsonData;
    id _delegate;
    SEL _success;
    SEL _error;
}

-(id)initWithUrl:(NSString *)url dictionary:(NSDictionary *)dict delegate:(id)delegate success:(SEL)success andError:(SEL)error;

@property(nonatomic, strong)NSURL * url;
@property(nonatomic, strong)NSData * jsonData;
@property(nonatomic)id delegate;
@property(nonatomic)SEL success;
@property(nonatomic)SEL error;

@end
