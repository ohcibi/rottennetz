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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // No turning back from here!!! Only by stop tracking
    self.navigationController.navigationBarHidden = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    self.client = [KeilerClient sharedClient];
    
    [self initTrack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTrack {
    NSString * urlRoot = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_root"];
    NSString * url = [NSString stringWithFormat:@"%@/api/tracks", urlRoot];
    NSString * auth_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"];
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:auth_token, @"auth_token", nil];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url dictionary:dict delegate:self success:@selector(successCreateTrack:) andError:@selector(failureCreateTrack)];
    
    [self.client startJSONRequest:request];
}

-(void)successCreateTrack:(NSDictionary *)response {
    int track_id = [[response objectForKey:@"track_id"] integerValue];
    self.tracker = [[Tracker alloc] initWithTrackId:track_id];
    [self.tracker startTracking];
}
-(void)failureCreateTrack:(NSDictionary *)response {
}

@end
