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
@synthesize lastSeen = _lastSeen;
@synthesize isOnline = _isONline;

+(id)userWithDictionary:(NSDictionary *)dictionary {
    User * user = [[self alloc] init];
    
    if (user) {
        user.user_id = [[dictionary objectForKey:@"id"] integerValue];
        user.name = [dictionary objectForKey:@"name"];
        user.email = [dictionary objectForKey:@"email"];
        user.md5email = [dictionary objectForKey:@"md5email"];
        user.tracks_count = [[dictionary objectForKey:@"tracks_count"] integerValue];
        user.lastSeen = [user dateFromString:[dictionary objectForKey:@"last_seen"]];
        user.isOnline = [[dictionary objectForKey:@"online?"] boolValue];
    }
    
    return user;
}

-(id)initWithName:(NSString *)name userId:(int)user_id andTracksCount:(int)tracks_count {
    self = [super init];
    if (self) {
        self.user_id = user_id;
        self.name = name;
        self.tracks_count = tracks_count;
    }
    return self;
}
-(id)initWithId:(int)user_id email:(NSString *)email andName:(NSString *)name {
    self = [super init];
    if (self) {
        self.user_id = user_id;
        self.email = email;
        self.name = name;
    }
    return self;
}
@end
