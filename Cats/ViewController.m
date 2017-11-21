//
//  ViewController.m
//  Cats
//
//  Created by Daniel Grosman on 2017-11-19.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "Photo.h"
#import "FlikrAPI.h"

@interface ViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray<Photo*> *photosArray;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDataFromAPI];
}
-(void)fetchDataFromAPI{
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
        self.photosArray = [allPhotos mutableCopy];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setCellImage:self.photosArray[indexPath.row].photoURL];
    cell.titleLabel.text = self.photosArray[indexPath.row].title;
    return cell;
    
}

@end
