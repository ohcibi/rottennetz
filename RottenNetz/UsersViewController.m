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

- (void)viewDidLoad {
    [super viewDidLoad];
    _users = [[NSMutableArray alloc] init];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Zum aktualisieren weiterziehen!"];
    [self.refreshControl addTarget:self
                            action:@selector(refreshUsers:)
                  forControlEvents:UIControlEventValueChanged];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadUsers];
}
- (void)refreshUsers:(id)sender {
    [self reloadUsers];
}
-(void)reloadUsers {
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:@"/api/users" delegate:self success:@selector(finishReloadUsers:) andError:@selector(failReloadUsers:)];
    
    [[KeilerHTTPClient sharedClient] startGETRequest:request];
}
-(void)finishReloadUsers:(NSDictionary *)response {
    [_users removeAllObjects];
    for (NSDictionary * user in response) {
        User * newUser = [[User alloc] initWithName:[user objectForKey:@"name"]
                                   userId:[[user objectForKey:@"id"] integerValue]
                           andTracksCount:[[user objectForKey:@"tracks_count"] integerValue]];
        newUser.md5email = [user objectForKey:@"md5email"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cid = @"UserCell";
    UserCell * cell = [tableView dequeueReusableCellWithIdentifier:cid];
    
    User * user = [_users objectAtIndex:indexPath.row];
    cell.titleLabel.text = user.name;
    cell.detailsLabel.text = [NSString stringWithFormat:@"%d Tracks", user.tracks_count];
    
    [cell.activityIndicator startAnimating];
    [[KeilerHTTPClient sharedClient] startAsyncOperationWithBlock:^(void) {
        NSString * gravatarUrl = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=112&d=retro", user.md5email];
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:gravatarUrl]];
        UIImage * gravatar = [UIImage imageWithData:imageData scale:2]; // retina compat
        cell.gravatarImage.image = gravatar;
        [cell.activityIndicator stopAnimating];
    }];
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
