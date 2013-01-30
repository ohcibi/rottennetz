//
//  RootViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "TracksViewController.h"

@implementation RootViewController {
    User * _user;
}
@synthesize tracker = _tracker;
@synthesize session = _session;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.session = [UserSession sharedSession];
    self.tracker = [TrackingService sharedTracker];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString * label;
    UIFont * font;
    if (self.session.user == nil) {
        label = @"Nicht angemeldet";
        font = [UIFont fontWithName:@"Georgia-Italic" size:14];
    } else {
        label = [NSString stringWithFormat:@"Angemeldet als: %@", self.session.user.name];
        font = [UIFont fontWithName:@"Georgia" size:14];
    }
    
    self.loggedInInfoLabel.text = label;
    self.loggedInInfoLabel.font = font;
    
    if (self.tracker.tracking) {
        [self.trackingButton setTitle:@"Zum Tracking" forState:UIControlStateNormal];
        [self.trackingButton setBackgroundImage:[UIImage imageNamed:@"footprints.png"] forState:UIControlStateNormal];
    } else {
        [self.trackingButton setTitle:@"Tracking starten" forState:UIControlStateNormal];
        [self.trackingButton setBackgroundImage:[UIImage imageNamed:@"footprints_red.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return [identifier isEqualToString:@"loginSegue"] || self.session.user != nil;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"rootToTracksSegue"]) {
        TracksViewController * tvc = [segue destinationViewController];
        tvc.user = self.session.user;
    }
}

- (IBAction)prepareUserSession:(id)sender {
    if (self.session.user == nil) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Für die gewünschte Seite ist eine Anmeldung erforderlich" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self performSegueWithIdentifier:@"loginSegue" sender:sender];
    }
}

@end
