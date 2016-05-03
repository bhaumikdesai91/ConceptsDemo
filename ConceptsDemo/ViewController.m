//
//  ViewController.m
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import "ViewController.h"
#import "Custom Classes/MainMenuCell/MainMenuCell.h"

@interface ViewController (){
    NSMutableArray *arForMenuItems;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arForMenuItems = [[NSMutableArray alloc] init];
    [arForMenuItems addObject:[NSDictionary dictionaryWithObjects:@[@"",@"Notification Demo", @"NotificationDemo"]
                                                          forKeys:@[@"image", @"title",@"identifier"]]];
    
    [self.collectionForMenu registerClass:[MainMenuCell class] forCellWithReuseIdentifier:@"MainMenuCell"];
    [self.collectionForMenu registerNib:[UINib nibWithNibName:@"MainMenuCell" bundle:nil] forCellWithReuseIdentifier:@"MainMenuCell"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Methods 

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arForMenuItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainMenuCell *menu = (MainMenuCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MainMenuCell" forIndexPath:indexPath];
    [menu configureMenuWithDictionary:arForMenuItems[indexPath.row]];
    return menu;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat availableWidth = (collectionView.frame.size.width - 24)/2;
    
    CGFloat availableHeight = (collectionView.frame.size.height - 24)/2;
    
    return CGSizeMake(availableWidth ,availableHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8 ,8 , 8, 8);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[arForMenuItems[indexPath.row] valueForKey:@"identifier"] isEqualToString:@"NotificationDemo"]) {
        [self performSegueWithIdentifier:@"ShowNotificationView" sender:self];
    }
}

@end
