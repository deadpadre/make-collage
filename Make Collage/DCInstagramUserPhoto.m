//
//  DCInstagramUserPhoto.m
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import "DCInstagramUserPhoto.h"

@implementation DCInstagramUserPhoto

+ (DCInstagramUserPhoto *) photoWithJSONObject: (NSObject *) object {
    DCInstagramUserPhoto *photo = [DCInstagramUserPhoto new];
    photo.id = [object valueForKey:@"id"];
    photo.type = [object valueForKey:@"type"];
    photo.photoUrl = [object valueForKeyPath:@"images.thumbnail.url"];
    
    return photo;
}

@end
