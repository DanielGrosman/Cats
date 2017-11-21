//
//  Photo.h
//  Cats
//
//  Created by Daniel Grosman on 2017-11-19.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, strong) UIImage *photoImage;

@property (nonatomic, strong) NSString *farmId;
@property (nonatomic, strong) NSString *photoId;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *serverId;
@property (nonatomic,strong) NSString *title;

- (instancetype)initWithInfo:(NSDictionary*)info;
-(void)photoImageURL;

@end
