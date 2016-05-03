//
//  AppDelegate.h
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(BOOL)scheduleSimpleLocalNotification;
-(BOOL)scheduleInvitationLocalNotification;
-(BOOL)scheduleReplyLocalNotification;
@end

