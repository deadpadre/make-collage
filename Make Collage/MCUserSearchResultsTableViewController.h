//
//  MCUserSearchResultsTableViewController.h
//  Make Collage
//
//  Created by Tkachenko Dmitry on 27.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCUserSearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSString *searchPhrase;

@end
