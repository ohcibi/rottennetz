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
#import "TrackerService.h"

@interface RootViewController : UIViewController {
    UserSession * _session;
    TrackerService * _tracker;
}

- (IBAction)prepareUserSession:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *loggedInInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property(nonatomic, strong) TrackerService * tracker;
@property(nonatomic, strong) UserSession * session;
@end
