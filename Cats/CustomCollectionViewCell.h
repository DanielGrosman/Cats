//
//  CustomCollectionViewCell.h
//  Cats
//
//  Created by Daniel Grosman on 2017-11-19.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

-(void)setCellImage:(NSURL*)imageURL;

@end
