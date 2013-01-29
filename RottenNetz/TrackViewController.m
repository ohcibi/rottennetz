//
//  TrackViewController.m
//  RottenNetz
//
//  Created by ohcibi on 24.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#define USERANNOTATIONID @"userAnnotation"
#define STARTANNOTATIONID @"startAnnotation"
#define ENDANNOTATIONID @"endAnnotation"
#define USERANNOTATIONPADDING 1000
#define MAPREGIONCHANGEOFFSET 200

#import "TrackViewController.h"
#import "JSONRequest.h"
#import "KeilerHTTPClient.h"
#import "StalkerService.h"

@implementation TrackViewController
@synthesize track = _track;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    if (self.track.isFinished) {
        [self drawTrack];
    } else {
        StalkerService * stalker = [StalkerService sharedStalkerForTrackId:self.track.track_id];
        [stalker addObserver:self forKeyPath:@"location" options:NSKeyValueObservingOptionNew context:nil];
        [stalker startStalking];
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    if (!self.track.isFinished) {
        [[StalkerService sharedStalkerForTrackId:self.track.track_id] stopStalking];
        [[StalkerService sharedStalkerForTrackId:self.track.track_id] removeObserver:self forKeyPath:@"location"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)drawTrack {
    NSString * url = [NSString stringWithFormat:@"/api/tracks/%d/coordinates", self.track.track_id];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url delegate:self success:@selector(finishLoadCoordinates:) andError:@selector(failureLoadCoordinates:)];
    [[KeilerHTTPClient sharedClient] startGETRequest:request];
}
-(void)finishLoadCoordinates:(NSDictionary *)response {
    int i = 0, count = [response count];
    CLLocationCoordinate2D coordinates[count];
    for (NSDictionary * coordinate in response) {
        CLLocationCoordinate2D newCoordinate = CLLocationCoordinate2DMake([[coordinate objectForKey:@"lat"] floatValue], [[coordinate objectForKey:@"lng"] floatValue]);
        coordinates[i++] = newCoordinate;
    }
    _polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
    [self.mapView addOverlay:_polyline];
    [self addPinsForStart:coordinates[0] andEnd:coordinates[count-1]];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinates[count-1], USERANNOTATIONPADDING, USERANNOTATIONPADDING);
    [self.mapView setRegion:region animated:YES];
}
-(void)failureLoadCoordinates:(NSDictionary *)response {
}

-(void)addPinsForStart:(CLLocationCoordinate2D)start andEnd:(CLLocationCoordinate2D)end {
    _startAnnotation = [UserAnnotation annotationWithCoordinate:start];
    _endAnnotation = [UserAnnotation annotationWithCoordinate:end];
    [self.mapView addAnnotations:[NSArray arrayWithObjects:_startAnnotation, _endAnnotation, nil]];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    MKOverlayView * overlayView;
    if (overlay == _polyline) {
        if (nil == _polylineView) {
            _polylineView  = [[MKPolylineView alloc] initWithOverlay:overlay];
            _polylineView.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
            _polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
            _polylineView.lineJoin = kCGLineJoinRound;
            _polylineView.lineCap = kCGLineCapRound;
            _polylineView.lineWidth = 5;
        }
        overlayView = _polylineView;
    }
    return overlayView;
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation == _userAnnotation) {
        if (!_userAnnotationView) {
            _userAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:USERANNOTATIONID];
            _userAnnotationView.image = [UIImage imageNamed:@"map_pin_start.png"];
            _userAnnotationView.canShowCallout = YES;
        }
        return _userAnnotationView;
    } else if (annotation == _startAnnotation) {
        if (!_startAnnotationView) {
            _startAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:STARTANNOTATIONID];
            _startAnnotationView.image = [UIImage imageNamed:@"map_pin_start.png"];
        }
        return _startAnnotationView;
    } else if (annotation == _endAnnotation) {
        if (!_endAnnotationView) {
            _endAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ENDANNOTATIONID];
            _endAnnotationView.image = [UIImage imageNamed:@"map_pin_end.png"];
        }
        return _endAnnotationView;
    }
    
    return nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int kind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (kind == NSKeyValueChangeSetting) {
        CLLocation * newLocation = [change objectForKey:NSKeyValueChangeNewKey];
        if (!_userAnnotation) {
            _userAnnotation = [[UserAnnotation alloc] init];
            _userAnnotation.title = _track.user.name;
            [self.mapView addAnnotation:_userAnnotation];
        }
        _userAnnotation.coordinate = newLocation.coordinate;
        [self followLocation:newLocation];
    }
}

-(void)followLocation:(CLLocation *)newLocation {
    if (!_userLocation || [newLocation distanceFromLocation:_userLocation] > USERANNOTATIONPADDING-MAPREGIONCHANGEOFFSET) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
           newLocation.coordinate,
           USERANNOTATIONPADDING,
           USERANNOTATIONPADDING);
        [self.mapView setRegion:region animated:YES];
        _userLocation = newLocation;
    }
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
@end