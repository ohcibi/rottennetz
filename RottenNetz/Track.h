//
//  Track.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeilerModel.h"
#import "User.h"

@interface Track : KeilerModel {
    int _track_id;
    BOOL _isFinished;
    NSDate * _created_at;
    User * _user;
}

-(id)initWithId:(int)track_id finished:(BOOL)finished user:(User *)user andCreatedAt:(NSString *)created_at;

@property(nonatomic) int track_id;
@property(nonatomic) BOOL isFinished;
@property(nonatomic, strong) NSDate * created_at;
@property(nonatomic, strong, readonly) User * user;
@end
