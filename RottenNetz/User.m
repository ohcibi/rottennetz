//
//  User.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize user_id = _user_id;
@synthesize name = _name;
@synthesize email = _email;
@synthesize tracks_count = _tracks_count;

-(id)initWithName:(NSString *)name userId:(int)user_id andTracksCount:(int)tracks_count {
    self = [super init];
    if (self) {
        self.user_id = user_id;
        self.name = name;
        self.tracks_count = tracks_count;
    }
    return self;
}
-(id)initWithEmail:(NSString *)email andName:(NSString *)name {
    self = [super init];
    if (self) {
        self.email = email;
        self.name = name;
    }
    return self;
}
@end
