//
//  UserListController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"
#import "JSONRequest.h"
#import "KeilerHTTPClient.h"
#import "TracksViewController.h"
#import "UserCell.h"

@implementation UsersViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    _users = [[NSMutableArray alloc] init];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Zum aktualisieren weiterziehen!"];
    [self.refreshControl addTarget:self
                            action:@selector(refreshUsers:)
                  forControlEvents:UIControlEventValueChanged];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadUsers];
}
-(void)refreshUsers:(id)sender {
    [self reloadUsers];
}
-(void)reloadUsers {
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:@"/api/users" delegate:self success:@selector(finishReloadUsers:) andError:@selector(failReloadUsers:)];
    
    [[KeilerHTTPClient sharedClient] startGETRequest:request];
}
-(void)finishReloadUsers:(NSDictionary *)response {
    [_users removeAllObjects];
    for (NSDictionary * user in response) {
        User * newUser = [User userWithDictionary:user];
        [_users addObject:newUser];
    }
    [self.tableView reloadData];
    [self endRefreshing];
}
-(void)failReloadUsers:(NSDictionary *)response {
}
-(void)endRefreshing {
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd. MMM HH:mm:ss"];
    NSString * title = [NSString stringWithFormat:@"Zuletzt aktualisiert: %@", [f stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title];
    [self.refreshControl endRefreshing];
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_users count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cid = @"UserCell";
    UserCell * cell = [tableView dequeueReusableCellWithIdentifier:cid];
    
    User * user = [_users objectAtIndex:indexPath.row];
    cell.titleLabel.text = user.name;
    cell.detailsLabel.text = [NSString stringWithFormat:@"%d Tracks", user.tracks_count];
    
    if (nil == user.lastSeen) {
        cell.lastSeenLabel.text = @"Gar nicht";
        cell.lastSeenLabel.textColor = [UIColor colorWithRed:0.6 green:0.01 blue:0.01 alpha:1];
    } else {
        
        if([user isOnline]) {
            cell.lastSeenLabel.textColor =[UIColor colorWithRed:0.01 green:0.6 blue:0.01 alpha:1];
        } else {
            cell.lastSeenLabel.textColor =[UIColor colorWithRed:0.01 green:0.01 blue:0.6 alpha:1];
        }
    
        cell.lastSeenLabel.text = [user shortDateStringFromDate:user.lastSeen];
    }

    if (![cell.md5email isEqualToString:user.md5email]) {
        // we must load a new gravatar
        [cell.activityIndicator startAnimating];
        [cell.gravatarImage setAlpha:0];
        [[KeilerHTTPClient sharedClient] startAsyncOperationWithBlock:^(void) {
            NSString * gravatarUrl = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=112&d=retro", user.md5email];
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:gravatarUrl]];
            UIImage * gravatar = [UIImage imageWithData:imageData scale:2]; // retina compat
            cell.gravatarImage.image = gravatar;
            [cell.activityIndicator stopAnimating];
            
            [UIView animateWithDuration:1 animations:^(void) {
                [cell.gravatarImage setAlpha:1];
            }];
        }];
        cell.md5email = user.md5email;
    }
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"usersToTracksSegue"]) {
        User * user = [_users objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        TracksViewController * tvc = [segue destinationViewController];
        tvc.user = user;
    }
}
@end
