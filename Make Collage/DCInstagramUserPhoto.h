//
//  DCInstagramUserPhoto.h
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCInstagramUserPhoto : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *photoUrl;

+ (DCInstagramUserPhoto *) photoWithJSONObject: (NSObject *) object;

@end
