//
//  StalkerService.m
//  RottenNetz
//
//  Created by ohcibi on 26.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "StalkingService.h"
#import "KeilerHTTPClient.h"
#import "JSONRequest.h"


@interface StalkingService ()
+(StalkingService *)createStalkerForTrackId:(int)trackId;
@end

@implementation StalkingService
@synthesize track_id = _track_id;
@synthesize isStalking = _isStalking;
@synthesize location = _location;
@synthesize timer = _timer;
static NSMutableDictionary * _stalkers;

+(StalkingService *)sharedStalkerForTrackId:(int)track_id {
    if (nil == _stalkers) {
        _stalkers = [[NSMutableDictionary alloc] init];
    }
    NSNumber * numTrackId = [NSNumber numberWithInt:track_id];
    StalkingService * stalker = [_stalkers objectForKey:numTrackId];
    if (nil == stalker) {
        stalker = [self createStalkerForTrackId:track_id];
        [_stalkers setObject:stalker forKey:numTrackId];
    }
    return stalker;
}

+(StalkingService *)createStalkerForTrackId:(int)trackId {
    StalkingService * stalker = [[StalkingService alloc] initWithTrackId:trackId];
    return stalker;
}

-(StalkingService *)initWithTrackId:(int)track_id {
    self = [super init];
    if (self) {
        self.track_id = track_id;
    }
    return self;
}

-(void)startStalking {
    if (!self.isStalking) {
        self.isStalking = YES;
        NSRunLoop * runloop = [NSRunLoop currentRunLoop];
        self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(stalk) userInfo:nil repeats:YES];
        [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
        [runloop addTimer:self.timer forMode:UITrackingRunLoopMode];
        [self stalk]; // stalk once as the first invocation is after the timer
    }
}
-(void)stalk {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/coordinates/last", self.track_id];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url delegate:self success:@selector(finishLoadCoordinate:) andError:@selector(failureLoadCoordinate:)];
    [[KeilerHTTPClient sharedClient] startGETRequest:request];
}
-(void)finishLoadCoordinate:(NSDictionary *)coordinate {
    double lat = [[coordinate objectForKey:@"lat"] doubleValue];
    double lng = [[coordinate objectForKey:@"lng"] doubleValue];
    self.location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
}
-(void)failureLoadCoordinate:(NSDictionary *)response {
    
}

-(void)stopStalking {
    if (self.isStalking) {
        self.isStalking = NO;
        [self.timer invalidate];
    }
}
@end
