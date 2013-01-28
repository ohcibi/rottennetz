//
//  KeilerModel.m
//  RottenNetz
//
//  Created by ohcibi on 28.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "KeilerModel.h"

@implementation KeilerModel
-(NSDate *)dateFromString:(NSString *)dateString {
    if ([[NSNull null] isEqual:dateString]) {
        return nil;
    }
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
    return [formatter dateFromString:dateString];
}
-(NSString *)shortDateStringFromDate:(NSDate *)date {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm:ss"];
    return [formatter stringFromDate:date];
}
@end
