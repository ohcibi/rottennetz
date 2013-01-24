//
//  TracksViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TracksViewController : UITableViewController {
    User * _user;
    NSMutableArray * _tracks;
}

@property(nonatomic, strong) NSMutableArray * tracks;
@property(nonatomic, strong) User * user;

@end
