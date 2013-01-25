//
//  TrackViewController.m
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "TrackViewController.h"
#import "JSONRequest.h"
#import "KeilerClient.h"

@interface TrackViewController ()

@end

@implementation TrackViewController
@synthesize track = _track;
@synthesize polyline = _polyline;
@synthesize polylineView = _polylineView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self loadCoordinates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadCoordinates {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/coordinates", self.track.track_id];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url delegate:self success:@selector(finishLoadCoordinates:) andError:@selector(failureLoadCoordinates:)];
    [[KeilerClient sharedClient] startGETRequest:request];
}
-(void)finishLoadCoordinates:(NSDictionary *)response {
    int i = 0, count = [response count];
    CLLocationCoordinate2D coordinates[count];
    for (NSDictionary * coordinate in response) {
        coordinates[i++] = CLLocationCoordinate2DMake([[coordinate objectForKey:@"lat"] floatValue], [[coordinate objectForKey:@"lng"] floatValue]);
    }
    self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
    [self.mapView addOverlay:self.polyline];
}
-(void)failureLoadCoordinates:(NSDictionary *)response {
    NSLog(@"%@", [response description]);
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKOverlayView * overlayView;
    if (overlay == self.polyline) {
        if (nil == self.polylineView) {
            self.polylineView  = [[MKPolylineView alloc] initWithPolyline:self.polyline];
            self.polylineView.fillColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:0.8];
            self.polylineView.strokeColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:0.8];
            self.polylineView.lineWidth = 3;
        }
        overlayView = self.polylineView;
    }
    return overlayView;
}
@end
