//
//  TrackerService.m
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "TrackingService.h"
#import "JSONRequest.h"

@implementation TrackingService
@synthesize track_id = _track_id;
@synthesize tracking = _tracking;
@synthesize locationManager = _locationManager;
@synthesize lastLocation = _lastLocation;
@synthesize client = _client;

static TrackingService * _sharedTracker = nil;

+(TrackingService *)sharedTracker {
    if (nil == _sharedTracker) {
        _sharedTracker = [[TrackingService alloc] init];
    }
    return _sharedTracker;
}
-(TrackingService *)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        self.client = [KeilerHTTPClient sharedClient];
    }
    return self;
}

-(void)startTracking {
    [self.locationManager startUpdatingLocation];
    self.tracking = YES;
}
-(void)stopTracking {
    [self.locationManager stopUpdatingLocation];
    self.tracking = NO;
    self.lastLocation = nil;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * location = [locations lastObject];
    @synchronized(self.lastLocation) {
        if (nil == self.lastLocation ||
            [self accuracyRadiusOf:location intersectsAccuracyRadiusOf:self.lastLocation]) {
                self.lastLocation = location;
                [self uploadLocation:self.lastLocation];
        }
    }
}
-(BOOL)accuracyRadiusOf:(CLLocation *)oneLocation intersectsAccuracyRadiusOf:(CLLocation *)otherLocation {
    return [oneLocation distanceFromLocation:otherLocation] > (oneLocation.horizontalAccuracy + otherLocation.horizontalAccuracy);
}
-(void)uploadLocation:(CLLocation *)location {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/coordinates", self.track_id];
    NSString * lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString * lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSDictionary * coordinates = [NSDictionary dictionaryWithObjectsAndKeys: lat, @"lat", lng, @"lng", nil];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:coordinates, @"coordinates", nil];
    
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url dictionary:dict delegate:self success:@selector(successUploadLocation:) andError:@selector(failureUploadLocation:)];
    
    [self.client startPOSTRequest:request];
}
-(void)successUploadLocation:(NSDictionary *)response {
    NSLog(@"success response: %@", [response description]);
    
}
-(void)failureUploadLocation:(NSDictionary *)response {
    NSLog(@"fail response: %@", [response description]);
}

@end
