//
//  User.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    int _user_id;
    NSString * _name;
    NSString * _email;
    int _tracks_count;
}

-(id)initWithName:(NSString *)name userId:(int)user_id andTracksCount:(int)tracks_count;
-(id)initWithEmail:(NSString *)email andName:(NSString *)name;

@property(nonatomic) int user_id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic) int tracks_count;
@end
