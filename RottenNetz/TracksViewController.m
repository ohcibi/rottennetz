//
//  TracksViewController.m
//  RottenNetz
//
//  Created by ohcibi on 22.01.13.
//  Copyright (c) 2013 ohcibi. All rights reserved.
//

#import "TracksViewController.h"
#import "Track.h"
#import "JSONRequest.h"
#import "KeilerClient.h"

@interface TracksViewController ()

@end

@implementation TracksViewController
@synthesize tracks = _tracks;
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tracks = [[NSMutableArray alloc] init];
    
    [self setTitleLabel];
    [self loadTracks];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTracks {
    NSString * url = [NSString stringWithFormat:@"/api/users/%d/tracks", self.user.user_id];
    JSONRequest * request = [[JSONRequest alloc] initWithUrl:url delegate:self success:@selector(finishLoadTracks:) andError:@selector(failureLoadTracks:)];
    [[KeilerClient sharedClient] startGETRequest:request];
}
-(void)finishLoadTracks:(NSDictionary *)response {
    [self.tracks removeAllObjects];
    for (NSDictionary * track in response) {
        Track * newTrack = [[Track alloc] initWithId:[[track objectForKey:@"id"] integerValue]
                                        andCreatedAt:[track objectForKey:@"created_at"]];
        [self.tracks addObject:newTrack];
    }
    [self.tableView reloadData];
}
-(void)failureLoadTracks:(NSDictionary *)response {
    
}

-(void)setTitleLabel {
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.textColor = [UIColor whiteColor];
    label.text = self.user.name;
    self.navigationItem.titleView = label;
    [self.navigationItem setTitle:self.user.name];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell"];
    
    Track * track = [self.tracks objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Track %d", indexPath.row + 1];
    cell.detailTextLabel.text = [track shortCreatedAt];
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
