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
#import "UserAnnotation.h"

@interface TrackViewController : UIViewController <MKMapViewDelegate> {
    Track * _track;
    MKPolyline * _polyline;
    MKPolylineView * _polylineView;
    UserAnnotation * _userAnnotation;
    UserAnnotation * _startAnnotation;
    UserAnnotation * _endAnnotation;
    MKAnnotationView * _userAnnotationView;
    MKAnnotationView * _startAnnotationView;
    MKAnnotationView * _endAnnotationView;
    CLLocation * _userLocation;
}
- (IBAction)changeMapType:(UISegmentedControl *)sender;

@property(nonatomic, strong) Track * track;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
