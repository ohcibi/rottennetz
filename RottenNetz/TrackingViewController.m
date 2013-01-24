//
//  TrackingViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "TrackingViewController.h"
#import "JSONRequest.h"

@interface TrackingViewController ()

@end

@implementation TrackingViewController
@synthesize tracker = _tracker;
@synthesize client = _client;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.client = [KeilerClient sharedClient];
    self.tracker = [Tracker sharedTracker];
    
    if (!self.tracker.tracking) {
        [self initTrack];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTrack {
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:@"/api/tracks"
                                                    delegate:self
                                                     success:@selector(successCreateTrack:)
                                                    andError:@selector(failureCreateTrack:)];
    [self.client startJSONRequest:request];
}

-(void)successCreateTrack:(NSDictionary *)response {
    int track_id = [[response objectForKey:@"track_id"] integerValue];
    self.tracker.track_id = track_id;
    [self.tracker startTracking];
}
-(void)failureCreateTrack:(NSDictionary *)response {
    NSLog(@"Error: %@", [response description]);
}

- (IBAction)changeMapType:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex) {
        case 1: self.mapView.mapType = MKMapTypeSatellite; break;
        case 2: self.mapView.mapType = MKMapTypeHybrid; break;
        case 0:
        default:
            self.mapView.mapType = MKMapTypeStandard;
    }
}

- (IBAction)stopTracking:(id)sender {
    [self.tracker stopTracking];
    //TODO: go to TrackViewController
}
@end
