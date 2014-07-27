//
//  DSInstagramApiManager.h
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import "DCInstagramUser.h"
#import "DCInstagramUserPhoto.h"
#import <Foundation/Foundation.h>

@interface DCInstagramApiManager : NSObject

+ (DCInstagramApiManager *) sharedManager;
+ (void) setSharedManager:(DCInstagramApiManager *) apiManager;

- (void) searchUsersWithQuery: (NSString *)query
                      success:(void (^)(NSArray *users))success
                      failure:(void (^)(NSError *error))failure;


- (void) getPhotosOfUser: (DCInstagramUser *) user
                 success:(void (^)(NSArray *photos))success
                 failure:(void (^)(NSError *error))failure;

-(void) loadImageFromUrl: (NSString *) urlString success:(void (^)(UIImage *image))success
                 failure:(void (^)(NSError *error))failure;

@end
