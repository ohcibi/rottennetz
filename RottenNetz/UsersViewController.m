//
//  UserListController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"

@interface UsersViewController ()

@end

@implementation UsersViewController
@synthesize users;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User * user1 = [[User alloc] init];
    user1.name = @"Peter";
    user1.tracks = [[NSMutableArray alloc] initWithObjects:@"DUMMY", nil];
    
    User * user2 = [[User alloc] init];
    user2.name = @"Heinz";
    user2.tracks = [[NSMutableArray alloc] initWithObjects:@"DUMMY", @"DUMMY2", nil];
    
    users = [[NSMutableArray alloc] initWithObjects: user1, user2, nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Tracks", [user.tracks count]];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
