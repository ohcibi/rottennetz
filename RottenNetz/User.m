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
@synthesize tracks_count = _tracks_count;

-(id)initWithEmail:(NSString *)email andName:(NSString *)name {
    self = [super init];
    if (self) {
        self.email = email;
        self.name = name;
    }
    return self;
}
@end
