//
//  MCUserSearchResultsTableViewController.m
//  Make Collage
//
//  Created by Tkachenko Dmitry on 27.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import "MCUserSearchResultsTableViewController.h"
#import "MCUserSearchResultsTableViewCell.h"
#import "MCResultsCollectionViewController.h"
#import "DCInstagramApiManager.h"

@interface MCUserSearchResultsTableViewController ()

@end

@implementation MCUserSearchResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DCInstagramApiManager sharedManager] searchUsersWithQuery:self.searchPhrase success:^(NSArray *users) {
        NSLog(@"Number of found %@ users: %d", self.searchPhrase, [users count]);
        self.users = users;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error %@", [error localizedDescription]);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCUserSearchResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userSearchResultsCell" forIndexPath:indexPath];
    
    DCInstagramUser *user = [self.users objectAtIndex:indexPath.row];
    
    cell.user = user;
    cell.textLabel.text = user.fullName;
    cell.detailTextLabel.text = user.username;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"userPhotoPickerSegue"]) {
        NSLog(@"Trying to segue via userPhotoPickerSegue");
        MCResultsCollectionViewController *destination = segue.destinationViewController;
        destination.user = ((MCUserSearchResultsTableViewCell *) sender).user;
        
    }
}

@end
