//
//  AppDelegate.h
//  FocusCircle
//
//  Created by Liang Zhao on 15/5/26.
//  Copyright (c) 2015年 Liang Zhao. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NSDate+FCExtension.h"
#import "TimerModel.h"

static NSString *ReactiveFromBackground = @"ReactiveFromBackground";
static NSString *Relaunch = @"Relaunch";

@class ItemsTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSMutableArray *runningTimerControllers;
@property (copy, nonatomic) NSString *applicationStatus;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

