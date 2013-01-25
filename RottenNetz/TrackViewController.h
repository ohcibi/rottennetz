//
//  TrackViewController.h
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Track.h"

@interface TrackViewController : UIViewController <MKMapViewDelegate> {
    Track * _track;
    MKPolyline * _polyline;
    MKPolylineView * _polylineView;
}

@property(nonatomic, strong) Track * track;
@property(nonatomic, strong) MKPolyline * polyline;
@property(nonatomic, strong) MKPolylineView * polylineView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
