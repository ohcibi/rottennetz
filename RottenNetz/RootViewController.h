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

@interface RootViewController : UIViewController {
    UserSessionModel * session;
}
- (IBAction)prepareUserSession:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loggedInInfoLabel;
@end
