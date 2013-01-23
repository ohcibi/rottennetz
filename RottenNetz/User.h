//
//  User.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString * _name;
    NSString * _email;
    NSString * _auth_token;
    NSMutableArray * _tracks;
}

-(id)initWithEmail:(NSString *)email andAuthToken:(NSString *)auth_token;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *auth_token;
@property(nonatomic, strong) NSMutableArray *tracks;
@end
