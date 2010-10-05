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
    
    //  Repositories        http://develop.github.com/p/repo.html
	SDGithubTaskGetRepos,
	SDGithubTaskGetRepoNetwork,
	
	//	Repository
	SDGithubTaskGetRepoWatchers,
    
    //  User information    http://develop.github.com/p/users.html
    SDGithubTaskUserSearch,
    SDGithubTaskUserShow,               //  shows extra information if authenticated
    SDGithubTaskUserUpdate,             //  POST, requires authentication 
    SDGithubTaskUserFollowers,
    SDGithubTaskUserFollowing,
    SDGithubTaskUserWatchedRepos,
    SDGithubTaskUserFollow,             //  POST, requires authentication 
    SDGithubTaskUserUnFollow,           //  POST, requires authentication 
    
    //  Issue information   http://develop.github.com/p/issues.html
    SDGithubTaskIssuesList,
    SDGithubTaskIssuesShow,
    SDGithubTaskIssuesComments,
    
    //  Network API         http://develop.github.com/p/network.html
    SDGithubTaskNetworkMeta,
    SDGithubTaskNetworkData,
    
    //  Commits API         http://develop.github.com/p/commits.html
    SDGithubTaskCommitList,
    SDGithubTaskCommitListFile,
    SDGithubTaskCommitShow,
    
	SDGithubTaskMAX // NEVER use this value (srsly... kthxbye)
} SDGithubTaskType;

@interface SDGithubTask : SDNetTask {
	SDGithubTaskManager *githubManager;
    
    NSString *user;
    NSString *repo;

    //  Fields available for update with SDGithubTaskUserUpdate
    NSString *name;
    NSString *email;
    NSString *blog;
    NSString *company;
    NSString *location;
    
    NSString *searchTerm;
    
    //  Fields for Issues
    NSString *issueState;
    NSString *issueNumber;
    
    //  Fields for commits
    NSString *branch;
    NSString *sha;
    NSString *path;
    
    //  paramter received from network_meta call, used to get up-to-date network data 
    NSString *nethash;
}

@property (copy) NSString *user;
@property (copy) NSString *repo;
@property (copy) NSString *name;
@property (copy) NSString *email;
@property (copy) NSString *blog;
@property (copy) NSString *company;
@property (copy) NSString *location;
@property (copy) NSString *searchTerm;
@property (copy) NSString *issueState;
@property (copy) NSString *issueNumber;
@property (copy) NSString *branch;
@property (copy) NSString *sha;
@property (copy) NSString *path;

@end
