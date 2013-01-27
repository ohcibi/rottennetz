//
//  LoginViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "LoginViewController.h"
#import "KeilerHTTPClient.h"
#import "UserSession.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailField becomeFirstResponder];
    self.emailField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    
    self.logoutButton.enabled = [UserSession sharedSession].user != nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUserData {
    NSString * username = self.emailField.text;
    NSString * password = self.passwordField.text;
    JSONRequest * jsonRequest = [[JSONRequest alloc] initWithUrl:@"/api/sessions"
                                                      dictionary:[NSDictionary dictionaryWithObjectsAndKeys:username, @"email", password, @"password", nil]
                                                        delegate:self
                                                         success:@selector(loginSuccess:)
                                                        andError:@selector(loginFailure:)];
    [[KeilerHTTPClient sharedClient] startPOSTRequest:jsonRequest];
}

-(void)loginSuccess:(NSDictionary *)response {
    NSString * userAsJSON = [response objectForKey:@"user"];
    NSDictionary * user = [self userFromJSON:userAsJSON];
    NSNumber * user_id = [user objectForKey:@"id"];
    NSString * name = [user objectForKey:@"name"];
    NSString * email = [user objectForKey:@"email"];
    NSString * auth_token = [user objectForKey:@"authentication_token"];
    
    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:auth_token forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.passwordField resignFirstResponder];
    
    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"Anmeldung erfolgreich"
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
-(void)loginFailure:(NSDictionary *)response {
    NSString * message = [NSString stringWithFormat:@"Login fehlgeschlagen. %@.", [response objectForKey:@"message"], nil];
    [[[UIAlertView alloc] initWithTitle:@"Fehler"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(NSDictionary *)userFromJSON:(NSString *)userAsJSON {
    NSError * error;
    return [NSJSONSerialization JSONObjectWithData:[userAsJSON dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField  == self.emailField) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self setupUserData];
    }
    return NO; // == event.preventDefault();
}

- (IBAction)clearData:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[[UIAlertView alloc] initWithTitle:@"Gelöscht"
                                message:@"Userdaten gelöscht"
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissDialog:nil];
}

- (IBAction)dismissDialog:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
