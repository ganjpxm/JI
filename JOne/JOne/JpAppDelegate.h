//
//  JpAppDelegate.h
//  JOne
//
//  Created by Johnny on 26/9/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JpAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
