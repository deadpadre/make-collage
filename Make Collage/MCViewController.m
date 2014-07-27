//
//  MCViewController.m
//  Make Collage
//
//  Created by Tkachenko Dmitry on 26.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import "MCViewController.h"
#import "DCInstagramApiManager.h"
#import "MCUserSearchResultsTableViewController.h"

@interface MCViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameSearchTextField;

@end

@implementation MCViewController 
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"usersSearchResultsSegue"]) {
        NSLog(@"Trying to seague via usersSearchResultsSegue");
        MCUserSearchResultsTableViewController *destination = segue.destinationViewController;
        destination.searchPhrase = self.usernameSearchTextField.text;
    }
}

@end
