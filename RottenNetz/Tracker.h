//
//  Tracker.h
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "KeilerClient.h"

@interface Tracker : NSObject <CLLocationManagerDelegate> {
    int _track_id;
    BOOL _tracking;
    CLLocationManager * _locationManager;
    CLLocation * _lastLocation;
    KeilerClient * _client;
}

+(Tracker *)sharedTracker;

-(void)startTracking;
-(void)stopTracking;

@property(nonatomic) int track_id;
@property(nonatomic) BOOL tracking;
@property(nonatomic, strong) CLLocationManager * locationManager;
@property(nonatomic, strong) CLLocation * lastLocation;
@property(nonatomic, strong) KeilerClient * client;
@end
