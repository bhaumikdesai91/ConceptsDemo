//
//  NotificationViewController.m
//  ConceptsDemo
//
//  Created by Bhaumik P. Desai on 25/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController (){
    NSArray *arForItems;
}

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arForItems = [[NSArray alloc] initWithObjects: @"Send Local Notification", @"Send Notification With Action Buttons", @"Send Notification With Reply Action", @"Cancel Notifications", @"Clear Badges", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else {
        return arForItems.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        UISwitch *switchView = (UISwitch *)[cell viewWithTag:21];
        [switchView setOn:TRUE];
        return cell;
    }else {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"Default" forIndexPath:indexPath];
        if (!cell) {
            cell = [(UITableViewCell *)[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Default"];
        }
        [[cell textLabel] setText:arForItems[indexPath.row]];
        
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Enable/Disable Notifications";
    }else {
        return @"Click to demonstrate a notification";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        switch (indexPath.row) {
            case 0:
                //Send Local Notification
                if([APP_DELEGATE scheduleSimpleLocalNotification]){
                    NSLog(@"Simple Notification Scheduled!");
                }else{
                    NSLog(@"Something Went Wrong!");
                }
                break;
            case 1:
                //Send Notification With Invitation Action
                if([APP_DELEGATE scheduleInvitationLocalNotification]){
                    NSLog(@"Invitation Notification Scheduled!");
                }else{
                    NSLog(@"Something Went Wrong!");
                }
                break;
            case 2:
                //Send Notification With Reply Actions
                if([APP_DELEGATE scheduleReplyLocalNotification]){
                    NSLog(@"Reply Notification Scheduled!");
                }else{
                    NSLog(@"Something Went Wrong!");
                }
                break;
            case 3:
                //Cancel All Scheduled notifications
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                break;
            case 4:
                //Clear Icon Badge
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                break;
            default:
                break;
        }
    }
}

@end
