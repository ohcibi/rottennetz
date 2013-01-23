//
//  RootViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController {
    User * _user;
}

-(User *)user {
    NSString * email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString * auth_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"auth_token"];
    if ([email isEqualToString:@""] || [auth_token isEqualToString:@""]) return nil;
    
    if (nil == _user
        || ![_user.email isEqualToString:email]
        || ![_user.auth_token isEqualToString:auth_token]) {
        _user = [[User alloc] initWithEmail:email andAuthToken:auth_token];
    }
    return _user;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    session = [UserSessionModel sharedSession];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    session.user = [self user];
    
    NSString * label;
    UIFont * font;
    if (session.user == nil) {
        label = @"Nicht angemeldet";
        font = [UIFont fontWithName:@"Georgia-Italic" size:17];
    } else {
        label = [NSString stringWithFormat:@"Angemeldet als: %@", session.user.email];
        font = [UIFont fontWithName:@"Georgia" size:17];
    }
    
    self.loggedInInfoLabel.text = label;
    self.loggedInInfoLabel.font = font;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return [identifier isEqualToString:@"loginSegue"] || session.user != nil;
}

- (IBAction)prepareUserSession:(id)sender {
    if (session.user == nil) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Für die gewünschte Seite ist eine Anmeldung erforderlich" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self performSegueWithIdentifier:@"loginSegue" sender:sender];
    }
}

@end
