//
//  MCResultsCollectionViewController.h
//  Make Collage
//
//  Created by Tkachenko Dmitry on 26.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCResultsCollectionViewCell.h"
#import "DCInstagramUser.h"

@interface MCResultsCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) DCInstagramUser *user;
@property (strong, nonatomic) NSArray *photos;

@end
