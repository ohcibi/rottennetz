//
//  Tracker.m
//  RottenNetz
//
//  Created by ohcibi on 23.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "Tracker.h"
#import "JSONRequest.h"

@implementation Tracker
@synthesize track_id = _track_id;
@synthesize locationManager = _locationManager;
@synthesize lastLocation = _lastLocation;
@synthesize client = _client;

-(id)initWithTrackId:(int)track_id {
    self = [super init];
    if (self) {
        self.track_id = track_id;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        self.client = [KeilerClient sharedClient];
    }
    return self;
}

-(void)startTracking {
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * location = [locations lastObject];
    @synchronized(self.lastLocation) {
        if (nil == self.lastLocation || [location distanceFromLocation:self.lastLocation] > 10) {
                self.lastLocation = location;
                [self uploadLocation:self.lastLocation];
        }
    }
}
-(void)uploadLocation:(CLLocation *)location {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/coordinates", self.track_id];
    NSString * lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString * lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSDictionary * coordinates = [NSDictionary dictionaryWithObjectsAndKeys: lat, @"lat", lng, @"lng", nil];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:coordinates, @"coordinates", nil];
    
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url dictionary:dict delegate:self success:@selector(successUploadLocation:) andError:@selector(failureUploadLocation:)];
    
    [self.client startJSONRequest:request];
}

-(void)successUploadLocation:(NSDictionary *)response {
    NSLog(@"success response: %@", [response description]);
    
}
-(void)failureUploadLocation:(NSDictionary *)response {
    NSLog(@"fail response: %@", [response description]);
}

@end
