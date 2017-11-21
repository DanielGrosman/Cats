//
//  CustomCollectionViewCell.m
//  Cats
//
//  Created by Daniel Grosman on 2017-11-19.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

-(void)setCellImage:(NSURL*)imageURL{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];

    [task resume];
}

@end
