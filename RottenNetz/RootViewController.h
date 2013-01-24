//
//  RootViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserSessionModel.h"
#import "Tracker.h"

@interface RootViewController : UIViewController {
    UserSessionModel * _session;
    Tracker * _tracker;
}

- (IBAction)prepareUserSession:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *loggedInInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *trackingButton;
@property(nonatomic, strong) Tracker * tracker;
@property(nonatomic, strong) UserSessionModel * session;
@end
