//
//  UserSessionModel.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserSessionModel : NSObject {
    User * _user;
}
+(UserSessionModel *)sharedSession;

@property(nonatomic, strong) User * user;
@end
