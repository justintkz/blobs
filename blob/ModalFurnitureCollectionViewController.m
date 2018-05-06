//
//  ModalFurnitureCollectionViewController.m
//  blob
//
//  Created by Brehmer Chan on 5/5/18.
//  Copyright © 2018 Brehmer Chan. All rights reserved.
//

#import "ModalFurnitureCollectionViewController.h"
#import "collectionTitle.h"
#import "ViewController.h"

@interface ModalFurnitureCollectionViewController () {
    NSArray *furniturePhotos;
}

@end

@implementation ModalFurnitureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    furniturePhotos = [NSArray arrayWithObjects:@"Seesaw@3x.png", @"Pipes@3x.png", @"Rocking Horse@3x.png", @"Sandpit@3x.png", @"Tires@3x.png", @"Tire Swing@3x.png", @"Slide@3x.png", @"Slide 2@3x.png", @"Bricks@3x.png", @"Bars@3x.png", nil];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return furniturePhotos.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    collectionTitle *header = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionTitleView" forIndexPath:indexPath];
    }
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"Coin.png"];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%li", @"Balance: ", (long)userCash]];
    [myString appendAttributedString:attachmentString];
    
    header.titleLabel.attributedText = myString;
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *furnitureImageView = (UIImageView *)[cell viewWithTag:100];
    furnitureImageView.contentMode = UIViewContentModeScaleAspectFit;
    furnitureImageView.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    furnitureImageView.image = [UIImage imageNamed:[furniturePhotos objectAtIndex:indexPath.row]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, cell.bounds.size.width, 40)];
    NSArray *costs = [NSArray arrayWithObjects:@"50", @"80", @"70", @"20", @"40", @"80", @"100", @"100", @"30", @"110", nil];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"Coin.png"];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[costs objectAtIndex:indexPath.row]];
    [myString appendAttributedString:attachmentString];
    title.attributedText = myString;
    [cell.contentView addSubview:title];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 140);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* furniturePic = @{@"pic": [UIImage imageNamed:[furniturePhotos objectAtIndex:indexPath.row]]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exitShop" object:self userInfo:furniturePic];
    userCash -= 80;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//
//}


@end
