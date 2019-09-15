//
//  AppDelegate.h
//  PTSearch
//
//  Created by Divya Sivakumar on 9/14/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import YelpAPI;

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) IBOutlet  UINavigationController          *navigationController;


//+(PTAppDelegate *) sharedInstance;
+ (YLPClient *)sharedClient;

- (void)saveContext;


@end

