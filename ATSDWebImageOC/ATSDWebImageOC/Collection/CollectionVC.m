//
//  CollectionVC.m
//  ATSDWebImageOC
//
//  Created by hugengya on 2020/5/23.
//  Copyright © 2020 com.hefeichenye. All rights reserved.
//

#import "CollectionVC.h"

@interface CollectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init {
    
        
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
     layout.itemSize = CGSizeMake(200, 180);
       // 设置最小行间距
       layout.minimumLineSpacing = 20;
       // 设置垂直间距
       layout.minimumInteritemSpacing = 20;
       // 设置边缘的间距，默认是{0，0，0，0}
       layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    return  [self initWithCollectionViewLayout:layout];//NS_DESIGNATED_INITIALIZER
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

    return 23;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.clipsToBounds = YES;
    
    // Configure the cell
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor redColor];
    
    // 约束
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:imageView];
    NSLayoutConstraint *cstT = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *cstL = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *cstB = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *cstR = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [cell.contentView addConstraints:@[cstT, cstL, cstB, cstR]];
    [cell.contentView layoutIfNeeded];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"placeholder_1.jpg"];
    UIImage *placeholder = [UIImage imageWithContentsOfFile:filePath];
    
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://www.droitstock.com/static/images/home/yinyue.jpg"] placeholderImage:placeholder options:SDWebImageProgressiveLoad];
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(floorf(self.view.frame.size.width - 20 * 2 - 20) * 0.5, 200);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
