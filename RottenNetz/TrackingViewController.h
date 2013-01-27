//
//  TrackingViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KeilerHTTPClient.h"
#import "TrackerService.h"

@interface TrackingViewController : UIViewController <UIAlertViewDelegate> {
    TrackerService * _tracker;
    KeilerHTTPClient * _client;
}
- (IBAction)changeMapType:(UISegmentedControl *)sender;
- (IBAction)stopTracking:(id)sender;

@property(nonatomic, weak) IBOutlet MKMapView * mapView;

@property(nonatomic, strong) TrackerService * tracker;
@property(nonatomic, strong) KeilerHTTPClient * client;
@end
