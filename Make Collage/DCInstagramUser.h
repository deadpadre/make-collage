//
//  DCInstagramUser.h
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCInstagramUser : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *fullName;

+ (DCInstagramUser *) userWithJSONObject: (NSObject *) object;

@end
