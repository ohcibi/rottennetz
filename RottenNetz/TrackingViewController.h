//
//  TrackingViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KeilerClient.h"
#import "Tracker.h"

@interface TrackingViewController : UIViewController {
    Tracker * _tracker;
    KeilerClient * _client;
}
- (IBAction)changeMapType:(UISegmentedControl *)sender;
- (IBAction)stopTracking:(id)sender;

@property(nonatomic, weak) IBOutlet MKMapView * mapView;

@property(nonatomic, strong) Tracker * tracker;
@property(nonatomic, strong) KeilerClient * client;
@end
