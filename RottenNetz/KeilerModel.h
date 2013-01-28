//
//  KeilerModel.h
//  RottenNetz
//
//  Created by ohcibi on 28.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeilerModel : NSObject
-(NSDate *)dateFromString:(NSString *)dateString;
-(NSString *)shortDateStringFromDate:(NSDate *)date;
@end
