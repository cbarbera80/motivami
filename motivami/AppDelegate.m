//
//  AppDelegate.m
//  motivami
//
//  Created by claudio barbera on 13/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "MKLocalNotificationsScheduler.h"
#import "Frase.h"
#import "Programma.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"pRVyUlitVHgaiWJEZlwDr8aaEWEItPPrsGU7xndE"
                  clientKey:@"2mqxsg7odhuGQXktKBf5RUw6Vx9dyu0DXhI9TmTF"];
    
   // [self sincronizzaDB];
    
    
    // Override point for customization after application launch.
    return YES;

    
    // Override point for customization after application launch.
    return YES;
}


/*
-(void)sincronizzaDB
{
    
    
    PFQuery *qProgrammi = [PFQuery queryWithClassName:@"Programmi"];
    
    [qProgrammi findObjectsInBackgroundWithBlock:^(NSArray *programmi, NSError *error) {
       
        for (PFObject *programma in programmi) {
            
            if (![self controllaSeOggetto:@"Programma" esisteConCodice:programma.objectId])
            {
                Programma *p = [NSEntityDescription insertNewObjectForEntityForName:@"Programma" inManagedObjectContext:self.managedObjectContext];
                p.codice = programma.objectId;
                p.descrizione = [programma objectForKey:@"descrizione"];
                p.bloccato = [NSNumber numberWithBool: [[programma objectForKey:@"bloccato"] boolValue]];
                
                NSError *err;
                
                if (![self.managedObjectContext save:&err])
                {
                    NSLog(@"Errore");
                }
            }
        }
        
    }];
    
    
    
    
    PFQuery *q = [PFQuery queryWithClassName:@"Frasi"];
    [q includeKey:@"programma"];
    [q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *frase in objects) {
            
            if (![self controllaSeOggetto:@"Frase" esisteConCodice:frase.objectId])
            {
                Frase *f = [NSEntityDescription insertNewObjectForEntityForName:@"Frase" inManagedObjectContext:self.managedObjectContext];
                f.codice = frase.objectId;
                f.descrizione = [frase objectForKey:@"descrizione"];
                f.suono = [frase objectForKey:@"suono"];
                
                PFObject *prg = [frase objectForKey:@"programma"];
                f.codiceProgramma = prg.objectId;
                
                NSError *err;
                
                if (![self.managedObjectContext save:&err])
                {
                    NSLog(@"Errore");
                }
                
            }
        }
        
        
    }];
}

*/
-(BOOL)controllaSeOggetto:(NSString *)oggetto esisteConCodice:(NSString *)codice{
    
    NSUInteger count;
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:oggetto inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(codice = %@)", codice];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil) {
        count = [array count]; // May be 0 if the object has been deleted.
        
        
    }
    else {
        return false;
    }
    
    return count > 0;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"appMotiv.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
