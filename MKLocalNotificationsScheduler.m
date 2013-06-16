//
//  MKLocalNotificationsScheduler.m
//  OrderList
//
//  Created by claudio barbera on 11/06/13.
//  Copyright 2013 claudio barbera. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://blog.mugunthkumar.com)
//  More information about this template on the post http://mk.sg/89	
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import "MKLocalNotificationsScheduler.h"

static MKLocalNotificationsScheduler *_instance;

@implementation MKLocalNotificationsScheduler

#pragma mark -
#pragma mark Singleton Methods

@synthesize badgeCount = _badgeCount;
+ (MKLocalNotificationsScheduler*)sharedInstance
{
	@synchronized(self) {
        
        if (_instance == nil) {
            
			// iOS 4 compatibility check
			Class notificationClass = NSClassFromString(@"UILocalNotification");
            
			if(notificationClass == nil)
			{
				_instance = nil;
			}
			else
			{
				_instance = [[super allocWithZone:NULL] init];
				_instance.badgeCount = 0;
			}
        }
    }
    return _instance;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}




- (void) scheduleNotificationOn:(NSDate*) fireDate
                           text:(NSString*) alertText
                         action:(NSString*) alertAction
                          sound:(NSString*) soundfileName
                    launchImage:(NSString*) launchImage
                        andInfo:(NSDictionary*) userInfo


{
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
    
	if(soundfileName == nil)
	{
		localNotification.soundName = UILocalNotificationDefaultSoundName;
	}
	else
	{
		localNotification.soundName = soundfileName;
	}
    
	localNotification.alertLaunchImage = launchImage;
    
	self.badgeCount ++;
    localNotification.applicationIconBadgeNumber = self.badgeCount;
    localNotification.userInfo = userInfo;
    
	// Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (void) clearBadgeCount
{
	self.badgeCount = 0;
	[UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeCount;
}

- (void) decreaseBadgeCountBy:(int) count
{
	self.badgeCount -= count;
	if(self.badgeCount < 0) self.badgeCount = 0;
    
	[UIApplication sharedApplication].applicationIconBadgeNumber = self.badgeCount;
}

- (void) handleReceivedNotification:(UILocalNotification*) thisNotification
{
	NSLog(@"Received: %@",[thisNotification description]);
	[self decreaseBadgeCountBy:1];
}

@end
