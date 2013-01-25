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
#import "KeilerClient.h"
#import "TracksViewController.h"

@interface UsersViewController ()

@end

@implementation UsersViewController
@synthesize users;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadUsers];
}
- (IBAction)refreshUsers:(id)sender {
    [self reloadUsers];
}
-(void)reloadUsers {
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:@"/api/users" delegate:self success:@selector(reloadedUsers:) andError:@selector(failReloadUsers:)];
    
    [[KeilerClient sharedClient] startGETRequest:request];
}
-(void)reloadedUsers:(NSDictionary *)response {
    [self.users removeAllObjects];
    for (NSDictionary * user in response) {
        User * newUser = [[User alloc] initWithName:[user objectForKey:@"name"]
                                   userId:[[user objectForKey:@"id"] integerValue]
                           andTracksCount:[[user objectForKey:@"tracks_count"] integerValue]];
        [self.users addObject:newUser];
    }
    [self.tableView reloadData];
}
-(void)failReloadUsers:(NSDictionary *)response {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cid = @"UserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    
    User * user = [self.users objectAtIndex:indexPath.row];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Tracks", user.tracks_count];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"usersToTracksSegue"]) {
        User * user = [self.users objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        TracksViewController * tvc = [segue destinationViewController];
        tvc.user = user;
    }
}
@end
