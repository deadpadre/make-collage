//
//  DCInstagramUser.m
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import "DCInstagramUser.h"

@implementation DCInstagramUser

+ (DCInstagramUser *) userWithJSONObject: (NSObject *) object {
    DCInstagramUser *user = [DCInstagramUser new];
    [user setValuesForKeysWithDictionary:[object dictionaryWithValuesForKeys:@[@"id", @"username"]]];
    user.fullName = [object valueForKey:@"full_name"];
    return user;
}

@end
