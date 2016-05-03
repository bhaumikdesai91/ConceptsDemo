//
//  AppDelegate.m
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"]);
    [self registerForNotificationsForApplication:application];
    
    return YES;
}

-(void)registerForNotificationsForApplication:(UIApplication *)application{
    //Registering with the local notification types.
    UIUserNotificationType notificationType = (UIUserNotificationType)UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
    
    //Create actions for invitation notification.
    UIMutableUserNotificationAction *acceptAction = [(UIMutableUserNotificationAction *)[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"ACCEPT_ACTION";
    acceptAction.behavior = UIUserNotificationActionBehaviorDefault;
    acceptAction.destructive = NO;
    acceptAction.title = @"Accept";
    acceptAction.authenticationRequired = NO;
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    
    UIMutableUserNotificationAction *rejectAction = [(UIMutableUserNotificationAction *)[UIMutableUserNotificationAction alloc] init];
    rejectAction.identifier = @"REJECT_ACTION";
    rejectAction.behavior = UIUserNotificationActionBehaviorDefault;
    rejectAction.destructive = YES;
    rejectAction.title = @"Reject";
    rejectAction.authenticationRequired = NO;
    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
    
    //Create invitation category and add actions.
    UIMutableUserNotificationCategory *invitationCategory = [(UIMutableUserNotificationCategory *)[UIMutableUserNotificationCategory alloc] init];
    [invitationCategory setActions:@[acceptAction, rejectAction] forContext:(UIUserNotificationActionContextDefault)];
    invitationCategory.identifier = @"INVITATION";
    
    
    //Create actions for reply notification.
    UIMutableUserNotificationAction *replyAction = [(UIMutableUserNotificationAction *)[UIMutableUserNotificationAction alloc] init];
    replyAction.identifier = @"REPLY_ACTION";
    replyAction.behavior = UIUserNotificationActionBehaviorTextInput;
    replyAction.destructive = NO;
    replyAction.title = @"Reply";
    replyAction.authenticationRequired = NO;
    replyAction.activationMode = UIUserNotificationActivationModeBackground;
    
    //Create invitation category and add actions.
    UIMutableUserNotificationCategory *replyCategory = [(UIMutableUserNotificationCategory *)[UIMutableUserNotificationCategory alloc] init];
    [replyCategory setActions:@[replyAction] forContext:(UIUserNotificationActionContextDefault)];
    replyCategory.identifier = @"REPLY";
    
    //Create Categories for Push Notification Here.
    
    NSSet *categoriesSet = [[NSSet alloc] initWithObjects:invitationCategory, replyCategory, nil];
    
    UIUserNotificationSettings *settings = (UIUserNotificationSettings *)[UIUserNotificationSettings settingsForTypes:notificationType categories:categoriesSet];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:settings];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler{
    NSLog(@"%@",notification.userInfo.description);
    if ([identifier isEqualToString:@"ACCEPT_ACTION"]) {
        NSLog(@"Invitation Accepted!");
        completionHandler();
    }else if ([identifier isEqualToString:@"REJECT_ACTION"]){
        NSLog(@"Invitation Rejected!");
        completionHandler();
    }else if ([identifier isEqualToString:@"REPLY_ACTION"]){
        NSLog(@"Reply Action : %@",[responseInfo objectForKey:UIUserNotificationActionResponseTypedTextKey]);
        completionHandler();
    }else{
        return;
    }
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if(notificationSettings.types != UIUserNotificationTypeNone){
        if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
            [application registerForRemoteNotifications];
        }
    }
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *devToken = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<"withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@",devToken);
    [[NSUserDefaults standardUserDefaults] setObject:devToken forKey:@"DeviceToken"];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error.description);
}

-(BOOL)scheduleSimpleLocalNotification{
    
    UIUserNotificationSettings *settings = (UIUserNotificationSettings *)[[UIApplication sharedApplication] currentUserNotificationSettings];
    if (settings.types != UIUserNotificationTypeNone) {
        //Create and schedule the local notification.
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:20];
        localNotification.alertTitle = @"This is local notification.";
        localNotification.alertBody = @"This is the body of notification, You can add details of notification here.";
        localNotification.hasAction = NO;
        NSInteger currentBadge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        localNotification.applicationIconBadgeNumber = ++currentBadge;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        return TRUE;
    }else {
        //User has not given permission for receiving nootifications.
        return FALSE;
    }
}
-(BOOL)scheduleInvitationLocalNotification{
    
    UIUserNotificationSettings *settings = (UIUserNotificationSettings *)[[UIApplication sharedApplication] currentUserNotificationSettings];
    if (settings.types != UIUserNotificationTypeNone) {
        //Create and schedule the local notification.
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:20];
        localNotification.alertTitle = @"Invitation from Apple.";
        localNotification.alertBody = @"You're invited to connect with apple.";
        localNotification.hasAction = YES;
        localNotification.category = @"INVITATION";
        NSInteger currentBadge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        localNotification.applicationIconBadgeNumber = ++currentBadge;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        return TRUE;
    }else {
        //User has not given permission for receiving nootifications.
        return FALSE;
    }
}
-(BOOL)scheduleReplyLocalNotification{
    
    UIUserNotificationSettings *settings = (UIUserNotificationSettings *)[[UIApplication sharedApplication] currentUserNotificationSettings];
    if (settings.types != UIUserNotificationTypeNone) {
        //Create and schedule the local notification.
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:20];
        localNotification.alertTitle = @"Steve sent you a message.";
        localNotification.alertBody = @"This is the body of notification, You can add details of notification here.";
        localNotification.hasAction = YES;
        localNotification.category = @"REPLY";
        NSInteger currentBadge = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        localNotification.applicationIconBadgeNumber = ++currentBadge;
        localNotification.soundName = @"";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        return TRUE;
    }else {
        //User has not given permission for receiving nootifications.
        return FALSE;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
