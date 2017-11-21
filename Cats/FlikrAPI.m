//
//  FlikrAPI.m
//  Cats
//
//  Created by Daniel Grosman on 2017-11-21.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "FlikrAPI.h"

@implementation FlikrAPI

+ (void)searchFor:(NSString*)tag complete:(void (^)(NSArray *results))done{
    NSURL *flikrUrl = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=891e62844608a8b91877972a310e3afb&tags=cat"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL: flikrUrl];
    
    NSURLSessionTask *task= [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return;
        }
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if (resp.statusCode > 299) {
            NSLog(@"Bad status code: %ld", resp.statusCode);
            abort();
        }
        
        //        Start json parsing
        NSError *jsonError = nil;
        NSDictionary* photos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error:%@",jsonError.localizedDescription);
            return;
        }
        NSMutableArray *allPhotos = [[NSMutableArray alloc]init];
        
        for (NSDictionary* photoInfo in photos[@"photos"][@"photo"]) {
            Photo *photo = [[Photo alloc]initWithInfo:photoInfo];
            [photo photoImageURL];
            [allPhotos addObject:photo];
        }
        done([NSArray arrayWithArray:allPhotos]);
    }];
    [task resume];
}


+ (void)loadImage:(Photo*)photo completionHandler:(void (^)(UIImage *image))finishedCallback{
    if (photo.photoImage != nil) {
        finishedCallback(photo.photoImage);
    }
    else{
        NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:photo.photoURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage * image = [UIImage imageWithContentsOfFile:location.path];
            photo.photoImage = image;
        }];
        [task resume];
    }
}

@end
