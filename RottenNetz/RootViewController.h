//
//  RootViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserSession.h"
#import "TrackingService.h"

@interface RootViewController : UITableViewController {
    UserSession * _session;
    TrackingService * _tracker;
}

- (IBAction)prepareUserSession:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *loggedInInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property(nonatomic, strong) TrackingService * tracker;
@property(nonatomic, strong) UserSession * session;
@end
