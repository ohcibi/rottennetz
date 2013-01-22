//
//  UserSessionModel.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserSessionModel : NSObject

@property(nonatomic, strong) NSString * auth_token;
@property(nonatomic, strong) User * user;
@end
