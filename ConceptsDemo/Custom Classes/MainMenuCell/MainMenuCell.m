//
//  MainMenuCell.m
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import "MainMenuCell.h"

@implementation MainMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.viewForBackground.layer setCornerRadius:5.0f];
    [self.viewForBackground.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.viewForBackground.layer setShadowOpacity:0.4f];
    [self.viewForBackground.layer setShadowRadius:5.0f];
    // Initialization code
}

-(void)configureMenuWithDictionary:(NSDictionary *)dict{
    if ([dict valueForKey:@"image"] != nil) {
        [self.imgView setImage:[UIImage imageNamed:[dict valueForKey:@"image"]]];
    }
    if ([dict valueForKey:@"title"] != nil) {
        [self.lblMenuName setText:[dict valueForKey:@"title"]];
    }
}

@end
