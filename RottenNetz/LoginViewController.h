//
//  LoginViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController <UITextFieldDelegate>
- (IBAction)setupUserSession:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end
