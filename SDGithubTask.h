//
//  SDGithubTask.h
//  CocoaREST
//
//  Created by Clint Shryock on 3/6/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDNetTask.h"

@class SDGithubTaskManager;

typedef enum _SDGithubTaskType {
	SDGithubTaskDoNothing,
	SDGithubTaskGetRepos,
    
	SDGithubTaskMAX // NEVER use this value (srsly... kthxbye)
} SDGithubTaskType;

@interface SDGithubTask : SDNetTask {
	SDGithubTaskManager *githubManager;
    
    NSString *user;
    NSString *repo;
}

@property (copy) NSString *user;
@property (copy) NSString *repo;

@end
