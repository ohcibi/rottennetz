//
//  Track.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject {
    int _track_id;
    NSDate * _created_at;
}

-(id)initWithId:(int)track_id andCreatedAt:(NSString *)created_at;
-(NSString *)shortCreatedAt;

@property(nonatomic) int track_id;
@property(nonatomic, strong) NSDate * created_at;
@end
