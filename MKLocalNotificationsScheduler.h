//
//  MKLocalNotificationsScheduler.h
//  OrderList
//
//  Created by claudio barbera on 11/06/13.
//  Copyright 2013 claudio barbera. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://blog.mugunthkumar.com)
//  More information about this template on the post http://mk.sg/89
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <Foundation/Foundation.h>

@interface MKLocalNotificationsScheduler : NSObject
{

    int _badgeCount;
}
+ (MKLocalNotificationsScheduler*) sharedInstance;

- (void) scheduleNotificationOn:(NSDate*) fireDate
						   text:(NSString*) alertText
						 action:(NSString*) alertAction
						  sound:(NSString*) soundfileName
					launchImage:(NSString*) launchImage
						andInfo:(NSDictionary*) userInfo;

- (void) handleReceivedNotification:(UILocalNotification*) thisNotification;

- (void) decreaseBadgeCountBy:(int) count;
- (void) clearBadgeCount;

@property int badgeCount;

@end
