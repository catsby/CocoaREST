//
//  SDGithubTaskManager.h
//  CocoaREST
//
//  Created by Clint Shryock on 3/6/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDNetTaskManager.h"

#import "SDGithubTask.h"

@interface SDGithubTaskManager : SDNetTaskManager {
	int limitMaxAmount;
	int limitRemainingAmount;
	NSTimeInterval limitResetEpochDate;
    
    NSString *repo;
    NSString *user;     //  not necessarily the same as username
}

// the following properties are set during every task
// while they are read-write, don't set them; it defeats the point.

@property int limitMaxAmount;
@property int limitRemainingAmount;
@property NSTimeInterval limitResetEpochDate;

@property (copy) NSString *repo;
@property (copy) NSString *user;

@end
