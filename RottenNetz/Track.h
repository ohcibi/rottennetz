//
//  Track.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

-(id)initWithTitle:(NSString *)myTitle;
-(NSString *)shortCreatedAt;

@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSDate * created_at;
@property(nonatomic, strong) NSMutableArray * coordinates;
@end
