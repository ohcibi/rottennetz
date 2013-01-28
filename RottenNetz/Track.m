//
//  Track.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "Track.h"

@implementation Track
@synthesize track_id = _track_id;
@synthesize isFinished = _isFinished;
@synthesize created_at = _created_at;
@synthesize user = _user;

-(id)initWithId:(int)track_id finished:(BOOL)finished user:(User *)user andCreatedAt:(NSString *)created_at {
    self = [super init];
    if (self) {
        self.track_id = track_id;
        _user = user;
        self.isFinished = finished;
        self.created_at = [self dateFromString:created_at];
    }
    return self;
}
@end