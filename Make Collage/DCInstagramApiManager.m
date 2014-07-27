//
//  DSInstagramApiManager.m
//  DavayCollage
//
//  Created by asivura on 25.01.14.
//  Copyright (c) 2014 asivura. All rights reserved.
//

#import "DCInstagramApiManager.h"
#import "DCInstagramClientId.h"

static DCInstagramApiManager *sharedApiManager;

@interface DCInstagramApiManager ()

@property (strong, nonatomic) NSOperationQueue * operationQueue;

@end

@implementation DCInstagramApiManager

NSString *const searchUsersUrl = @"https://api.instagram.com/v1/users/search";
NSString *const getPhotosUrl = @"https://api.instagram.com/v1/users/%@/media/recent";

+ (DCInstagramApiManager *) sharedManager
{
    return sharedApiManager;
}

+ (void) setSharedManager:(DCInstagramApiManager *)apiManager
{
    sharedApiManager = apiManager;
}

- (NSOperationQueue *) operationQueue
{
    if (_operationQueue) return _operationQueue;
    
    _operationQueue = [NSOperationQueue new];
    return _operationQueue;
}

- (void) searchUsersWithQuery: (NSString *)query
                      success:(void (^)(NSArray *users))success
                      failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@?%@", searchUsersUrl, [self urlEncodedStringWithDictionary:@{@"client_id": CLIENT_ID, @"q": query}]];
    

    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(connectionError);;
            });
            return;
        }
        
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);;
            });
            return;
        }
        
        NSMutableArray *users = [NSMutableArray new];
        for (id JSONObject in [jsonObject valueForKey:@"data"]) {
            [users addObject:[DCInstagramUser userWithJSONObject:JSONObject]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            success(users);
        });
    }];
}


- (void) getPhotosOfUser: (DCInstagramUser *) user
                 success:(void (^)(NSArray *photos))success
                 failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@?%@", [NSString stringWithFormat:getPhotosUrl, user.id], [self urlEncodedStringWithDictionary:@{@"client_id": CLIENT_ID}]];
    
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest: request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 
        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(connectionError);
            });
            return;
        }
        
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);;
            });
            return;
        }
        
        NSMutableArray *photos = [NSMutableArray new];
        for (id JSONObject in [jsonObject valueForKey:@"data"]) {
            [photos addObject:[DCInstagramUserPhoto photoWithJSONObject:JSONObject]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            success(photos);
        });
    }];
}

-(NSString*) urlEncodedStringWithDictionary:(NSDictionary *) dictionary
{
    NSMutableArray *parts = [NSMutableArray array];
    for (NSString * key in dictionary) {
        NSString *value = [dictionary objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

-(void) loadImageFromUrl: (NSString *) urlString success:(void (^)(UIImage *image))success
                 failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(connectionError);
            });
            return;
        }
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(image);
        });
        
    }];
    
    return;
    
}




@end
