//
//  MCResultsCollectionViewController.m
//  Make Collage
//
//  Created by Tkachenko Dmitry on 26.07.14.
//  Copyright (c) 2014 deadpadre. All rights reserved.
//

#import "MCResultsCollectionViewController.h"
#include "DCInstagramApiManager.h"
#include "DCInstagramUserPhoto.h"
#include "MCPreviewViewController.h"

@interface MCResultsCollectionViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *makeCollageButton;
@property (nonatomic) BOOL isMakingCollage;
@property (strong, nonatomic) NSMutableArray *chosenImages;

@end

@implementation MCResultsCollectionViewController

- (IBAction)makeCollageButtonTouched:(UIBarButtonItem *)sender {
    NSLog(@"Make Collage Button touched");
    if (!self.isMakingCollage) {
        self.isMakingCollage = YES;
        self.collectionView.allowsMultipleSelection = YES;
        self.collectionView.allowsSelection = YES;
        self.makeCollageButton.title = @"Превью";
    } else if (self.chosenImages.count == 4) {
        [self performSegueWithIdentifier:@"previewSegue" sender:sender];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isMakingCollage) {
        if (self.chosenImages.count >= 4) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
            return;
        }
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIImage *pickedImage = ((UIImageView *)[cell viewWithTag:100]).image;
        [self.chosenImages addObject:pickedImage];
        NSLog(@"Currently %d images selected", self.chosenImages.count);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isMakingCollage) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIImage *depickedImage = ((UIImageView *)[cell viewWithTag:100]).image;
        [self.chosenImages removeObject:depickedImage];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"resultsCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Blue"]];
    UIImageView *photoImageView = (UIImageView *)[cell viewWithTag:100];
    DCInstagramUserPhoto *photo = self.photos[indexPath.row];
    if (photo.photoUrl && [photo.type isEqualToString:@"image"]) {
        [[DCInstagramApiManager sharedManager] loadImageFromUrl:photo.photoUrl success:^(UIImage *image) {
            photoImageView.image = image;
        } failure:^(NSError *error) {
            photoImageView.image = [UIImage imageNamed:@"NoImage"];
            NSLog(@"Error %@", [error localizedDescription]);
        }];
    } else {
        photoImageView.image = [UIImage imageNamed:@"NoImage"];
    }
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.chosenImages = [NSMutableArray array];
    self.collectionView.allowsSelection = NO;
    [[DCInstagramApiManager sharedManager] getPhotosOfUser:self.user success:^(NSArray *photos) {
        NSLog(@"%d photos were get in last request", photos.count);
        self.photos = photos;
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"Error %@", [error localizedDescription]);
    }];
}

- (UIImage *)makeCollageWithChosenImages {
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    [self.chosenImages[0] drawInRect:CGRectMake(0, 0, 150, 150)];
    [self.chosenImages[1] drawInRect:CGRectMake(150, 0, 150, 150)];
    [self.chosenImages[2] drawInRect:CGRectMake(0, 150, 150, 150)];
    [self.chosenImages[3] drawInRect:CGRectMake(150, 150, 150, 150)];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"previewSegue"]) {
        NSLog(@"Trying to segue via previewSegue");
        MCPreviewViewController *destination = segue.destinationViewController;
        destination.previewImage = [self makeCollageWithChosenImages];
    }
}

@end
