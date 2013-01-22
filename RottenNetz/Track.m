//
//  Track.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "Track.h"

@implementation Track
@synthesize title;
@synthesize created_at;
@synthesize coordinates;

-(id)initWithTitle:(NSString *)myTitle {
    self = [super init];
    if (self) {
        self.title = myTitle;
        self.created_at = [NSDate date];
    }
    return self;
}
-(NSString *)shortCreatedAt {
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd. MMMM yyyy HH:mm:ss"];
    
    return [f stringFromDate:self.created_at];
}
@end