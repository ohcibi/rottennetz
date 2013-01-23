//
//  LoginViewController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSessionModel.h"
#import "KeilerClient.h"

@interface LoginViewController : UITableViewController <UITextFieldDelegate> {
    KeilerClient * _client;
}
- (void)setupUserData;
- (IBAction)clearData:(id)sender;
- (IBAction)dismissDialog:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property(nonatomic, strong) KeilerClient * client;
@end
