//
//  UserListController.h
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersViewController : UITableViewController {
    NSMutableArray * _users;
}
@property (strong, nonatomic) IBOutlet UITableView *usersTable;
@end
