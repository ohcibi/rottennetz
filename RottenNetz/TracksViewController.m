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
#import "TrackViewController.h"
#import "UserSession.h"

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
    if ([self isAllowedToEdit]) self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Zum aktualisieren weiterziehen!"];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTracks:)
                  forControlEvents:UIControlEventValueChanged];
}

-(BOOL)isAllowedToEdit {
    return self.user.user_id == [UserSession sharedSession].user.user_id;
}

- (void)refreshTracks:(UIRefreshControl *)refresh {
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Lade Tracks..."];
    [self loadTracks];
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
                                            finished:[[track objectForKey:@"finished"] boolValue]
                                                user:self.user
                                        andCreatedAt:[track objectForKey:@"created_at"]];
        [self.tracks addObject:newTrack];
    }
    [self.tableView reloadData];
    [self endRefreshing];
}
-(void)endRefreshing {
    NSDateFormatter * f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd. MMM HH:mm:ss"];
    NSString * title = [NSString stringWithFormat:@"Zuletzt aktualisiert: %@", [f stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title];
    [self.refreshControl endRefreshing];
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
    cell.textLabel.text = [NSString stringWithFormat:@"Track #%d", track.track_id];
    cell.detailTextLabel.text = [track shortCreatedAt];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tracksToTrackSegue"]) {
        TrackViewController * tvc = [segue destinationViewController];
        tvc.track = [self.tracks objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && [self isAllowedToEdit]) {
        Track * track = [self.tracks objectAtIndex:indexPath.row];
        [self.tracks removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSString * url = [NSString stringWithFormat:@"/api/tracks/%d", track.track_id];
        JSONRequest * request = [[JSONRequest alloc] initWithUrl:url delegate:self success:@selector(finishDeleteTrack:) andError:@selector(failureLoadTracks:)];
        [[KeilerClient sharedClient] startDELETERequest:request];
    }
}
-(void)finishDeleteTrack:(NSDictionary *)response {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Track gelöscht" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
-(void)failureDeleteTrack:(NSDictionary *)response {
    
}
@end
