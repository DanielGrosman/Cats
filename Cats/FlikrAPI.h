//
//  FlikrAPI.h
//  Cats
//
//  Created by Daniel Grosman on 2017-11-21.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface FlikrAPI : NSObject

+ (void)searchFor:(NSString*)tag complete:(void (^)(NSArray *results))done;

+ (void)loadImage:(Photo*)photo completionHandler:(void (^)(UIImage *image))finishedCallback;

@end
