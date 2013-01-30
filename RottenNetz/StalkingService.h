//
//  StalkerService.h
//  RottenNetz
//
//  Created by ohcibi on 26.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface StalkingService : NSObject {
    int _track_id;
    BOOL _isStalking;
    NSTimer * _timer;
    CLLocation * _location;
}

+(StalkingService *)sharedStalkerForTrackId:(int)track_id;

-(void)startStalking;
-(void)stalk;
-(void)stopStalking;

@property(nonatomic) int track_id;
@property(nonatomic) BOOL isStalking;
@property(nonatomic, strong) NSTimer * timer;
@property(nonatomic, strong) CLLocation * location;

@end
