//
//  NotificationViewController.h
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tblNotifications;

@end
