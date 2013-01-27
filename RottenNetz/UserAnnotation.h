//
//  UserAnnotation.h
//  RottenNetz
//
//  Created by ohcibi on 27.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface UserAnnotation : NSObject <MKAnnotation> {
    NSString * _title;
    CLLocationCoordinate2D _coordinate;
}

+(UserAnnotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate;

@property(nonatomic, strong) NSString * title;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end
