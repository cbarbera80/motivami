//
//  AppDelegate.h
//  motivami
//
//  Created by claudio barbera on 13/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@protocol SelectObjectDelegate <NSObject>

-(void)didSelectObject:(id)object;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end
