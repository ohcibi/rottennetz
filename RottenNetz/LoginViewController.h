//
//  LoginViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSession.h"
#import "KeilerHTTPClient.h"

@interface LoginViewController : UITableViewController <UITextFieldDelegate, UIAlertViewDelegate>

- (void)setupUserData;
- (IBAction)clearData:(id)sender;
- (IBAction)dismissDialog:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;

@end
