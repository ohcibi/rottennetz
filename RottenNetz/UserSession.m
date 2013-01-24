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
    NSString * email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString * name = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    if ([email isEqualToString:@""] || [name isEqualToString:@""]) return nil;
    
    if (nil == _user
        || ![_user.email isEqualToString:email]
        || ![_user.name isEqualToString:name]) {
        _user = [[User alloc] initWithEmail:email andName:name];
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
