//
//  AppDelegate.m
//  FocusCircle
//
//  Created by Liang Zhao on 15/5/26.
//  Copyright (c) 2015年 Liang Zhao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunch");
    
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
    

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"once");
        [self insertDemoData];
    }
    
     

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"willResign");
    

    

    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"didEnterBackground");
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"willEnterForeground");
    

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"didBecomeActive");
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"willTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Amztion.FocusCircle" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FocusCircle" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FocusCircle.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }else{
            [self.managedObjectContext save:&error];
        }
    }
    
}






#pragma mark - Insert Demo Data
-(void)insertDemoData{
    TimerModel *timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    NSNumber *createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    NSNumber *duration = [NSNumber numberWithInteger:17];
    
    [timer setValue:@"testData0" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:13];
    
    [timer setValue:@"testData1" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData2" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData3" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData4" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData5" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData6" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData7" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData8" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData9" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData10" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData11" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    timer = [NSEntityDescription insertNewObjectForEntityForName:@"TimerModel" inManagedObjectContext:self.managedObjectContext];
    
    createdDate = [NSNumber numberWithDouble:[[NSDate date]timeIntervalSince1970]];
    duration = [NSNumber numberWithInteger:19];
    
    [timer setValue:@"testData12" forKey:@"titleOfTimer"];
    [timer setValue:duration forKey:@"durationTime"];
    [timer setValue:createdDate forKey:@"sortValue"];
    
    NSError *error;
    
    [self.managedObjectContext save:&error];
}

@end
