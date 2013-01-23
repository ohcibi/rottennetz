//
//  LoginViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "LoginViewController.h"
#import "KeilerPoster.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.emailField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUserData {
    NSString * username = self.emailField.text;
    NSString * password = self.passwordField.text;
    KeilerPoster * loginPoster = [[KeilerPoster alloc] initWithDelegate:self andSuccess:@selector(loginSuccess:) andError:@selector(loginFailure:)];
    
    [loginPoster startRequestForURL:@"http://192.168.1.2:3000/api/sessions" andDictionary:[NSDictionary dictionaryWithObjectsAndKeys:username, @"email", password, @"password", nil]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (IBAction)clearData:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[[UIAlertView alloc] initWithTitle:@"Gelöscht" message:@"Userdaten gelöscht" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginSuccess:(NSDictionary *)response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString * auth_token = [response objectForKey:@"auth_token"];
    NSString * email = self.emailField.text;
    [[NSUserDefaults standardUserDefaults] setObject:auth_token forKey:@"auth_token"];
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.passwordField resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginFailure:(NSDictionary *)response {
    NSString * message = [NSString stringWithFormat:@"Login fehlgeschlagen. %@. Bitte überprüfe deine Daten.", [response objectForKey:@"message"], nil];
    [[[UIAlertView alloc] initWithTitle:@"Fehler"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField  == self.emailField) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self setupUserData];
    }
    return NO; // == event.preventDefault();
}
@end
