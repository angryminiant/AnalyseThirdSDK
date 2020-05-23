//
//  AppDelegate.h
//  ATSDWebImageOC
//
//  Created by hugengya on 2020/5/22.
//  Copyright © 2020 com.hefeichenye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

