//
//  LoginViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSessionModel.h"

@interface LoginViewController : UITableViewController <UITextFieldDelegate>
- (void)setupUserData;
- (IBAction)clearData:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end
