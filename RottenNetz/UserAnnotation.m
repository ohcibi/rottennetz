//
//  UserAnnotation.m
//  RottenNetz
//
//  Created by ohcibi on 27.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "UserAnnotation.h"

@implementation UserAnnotation
@synthesize title = _title;
@synthesize coordinate = _coordinate;

+(UserAnnotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate {
    UserAnnotation * annotation = [[self alloc] init];
    if (annotation) {
        annotation.coordinate = coordinate;
    }
    return annotation;
}

@end
