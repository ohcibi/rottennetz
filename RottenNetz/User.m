//
//  User.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize name = _name;
@synthesize email = _email;
@synthesize auth_token = _auth_token;
@synthesize tracks = _tracks;

-(id)initWithEmail:(NSString *)email andAuthToken:(NSString *)auth_token {
    self = [super init];
    if (self) {
        self.email = email;
        self.auth_token = auth_token;
    }
    return self;
}
@end
