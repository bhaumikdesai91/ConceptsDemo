//
//  MainMenuCell.h
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblMenuName;
@property (weak, nonatomic) IBOutlet UIView *viewForBackground;

-(void)configureMenuWithDictionary:(NSDictionary *)dict;

@end
