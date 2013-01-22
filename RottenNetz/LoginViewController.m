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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setupUserSession:(id)sender {
    NSString * username = self.usernameField.text;
    NSString * password = self.passwordField.text;
    KeilerPoster * loginPoster = [[KeilerPoster alloc] initWithDelegate:self andSuccess:@selector(loginSuccess:) andError:@selector(loginFailure:)];
    
    [loginPoster startRequestForURL:@"http://192.168.1.2:3000/api/sessions" andDictionary:[NSDictionary dictionaryWithObjectsAndKeys:username, @"email", password, @"password", nil]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)loginSuccess:(NSDictionary *)response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"Auth-Token: %@", [response objectForKey:@"auth_token"]);
    [self.passwordField resignFirstResponder];
}
-(void)loginFailure:(NSError *)error {
    // this is somehow not triggered when the request wasn't succesful
    NSLog(@"Login Failure");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField  == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self setupUserSession:textField];
    }
    return NO; // == event.preventDefault();
}
@end
