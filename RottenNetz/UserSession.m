//
//  UserSessionModel.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession
@synthesize user = _user;
@synthesize auth_token = _auth_token;
static UserSession * userSession = nil;

+(UserSession *)sharedSession {
    @synchronized(self) {
        if (nil == userSession) {
            userSession = [[self alloc] init];
        }
    }
    
    return userSession;
}

-(User *)user {
    int user_id = [[NSUserDefaults standardUserDefaults] integerForKey:@"user_id"];
    if (user_id == 0) return nil;
    
    NSString * email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString * name = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    
    if (nil == _user || _user.user_id != user_id) {
        _user = [[User alloc] initWithId:user_id email:email andName:name];
    }
    return _user;
}
-(NSString *)auth_token {
    NSString * auth_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"];
    if (nil == _auth_token || ![_auth_token isEqualToString:auth_token]) {
        self.auth_token = auth_token;
    }
    
    return _auth_token;
}

@end
