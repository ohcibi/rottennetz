//
//  User.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Keilermodel.h"

@interface User : KeilerModel {
    int _user_id;
    NSString * _name;
    NSString * _email;
    NSString * _md5email;
    int _tracks_count;
    NSDate * _lastSeen;
    BOOL _isOnline;
}

+(id)userWithDictionary:(NSDictionary *)dictionary;

-(id)initWithName:(NSString *)name userId:(int)user_id andTracksCount:(int)tracks_count;
-(id)initWithId:(int)user_id email:(NSString *)email andName:(NSString *)name;
-(BOOL)isOnline;

@property(nonatomic) int user_id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *md5email;
@property(nonatomic) int tracks_count;
@property(nonatomic, strong) NSDate * lastSeen;
@property(nonatomic) BOOL isOnline;
@end
