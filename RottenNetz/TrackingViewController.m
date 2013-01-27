//
//  TrackingViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "TrackingViewController.h"
#import "JSONRequest.h"

@implementation TrackingViewController
@synthesize tracker = _tracker;
@synthesize client = _client;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.client = [KeilerHTTPClient sharedClient];
    self.tracker = [TrackerService sharedTracker];
    
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
    [self.client startPOSTRequest:request];
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
    [self finishTrack];
}

-(void)finishTrack {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/finish", self.tracker.track_id];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url
                                                    delegate:self
                                                     success:@selector(successFinishTrack:)
                                                    andError:@selector(failureFinishTrack:)];
    [[KeilerHTTPClient sharedClient] startPUTRequest:request];
}
-(void)successFinishTrack:(NSDictionary *)response {
    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"Track abgeschlossen"
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
-(void)failureFinishTrack:(NSDictionary *)response {
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
