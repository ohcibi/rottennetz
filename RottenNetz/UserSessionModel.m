//
//  UserSessionModel.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "UserSessionModel.h"

@implementation UserSessionModel
@synthesize user = _user;
static UserSessionModel * userSession = nil;

+(UserSessionModel *)sharedSession {
    @synchronized(self) {
        if (nil == userSession) {
            userSession = [[self alloc] init];
        }
    }
    
    return userSession;
}

@end
