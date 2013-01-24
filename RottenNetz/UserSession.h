//
//  UserSessionModel.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserSession : NSObject {
    User * _user;
    NSString * _auth_token;
}
+(UserSession *)sharedSession;

@property(nonatomic, strong) User * user;
@property(nonatomic, strong) NSString * auth_token;
@end
