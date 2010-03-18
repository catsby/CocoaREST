//
//  GithubDelegate.m
//  CocoaREST
//
//  Created by Clint Shryock on 3/6/10.
//  Copyright 2010. All rights reserved.
//

#import "GithubDelegate.h"


@implementation GithubDelegate

@synthesize isWaiting;
@synthesize repositories;
@synthesize forks;
@synthesize user;

- (void) awakeFromNib
{
	manager = [[SDGithubTaskManager manager] retain];
	manager.delegate = self;
	manager.successSelector = @selector(githubManager:resultsReadyForTask:);
	manager.failSelector = @selector(githubManager:failedForTask:);
	manager.maxConcurrentTasks = 3;
}

- (IBAction) runTask:(id)sender {
	
	SDGithubTask *basicTask = [SDGithubTask taskWithManager:manager];
	manager.username = [userField stringValue];
	manager.password = [apiTokenField stringValue];
	basicTask.type = [[taskTypeButton selectedItem] tag];
    basicTask.user = [userField stringValue];
	[basicTask run];
	
	self.isWaiting = YES;
}

- (void) githubManager:(SDGithubTaskManager*)manager resultsReadyForTask:(SDGithubTask*)task {
	self.repositories = [task.results valueForKey:@"repositories"];
    self.user         = [task.results objectForKey:@"user"];
	self.forks = [task.results valueForKey:@"network"];

	self.isWaiting = NO;
}

- (void) githubManager:(SDGithubTaskManager*)manager failedForTask:(SDGithubTask*)task {
	self.isWaiting = NO;
	
	self.repositories = nil;
	
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"Error"];
	[alert setInformativeText:[task.error localizedDescription]];
	[alert runModal];
}


- (void) tableViewSelectionDidChange:(NSNotification *)notification {
    NSUInteger index = [repositoriesView selectedRow];
    if (self.repositories) {
        SDGithubTaskManager *forkManager = [[SDGithubTaskManager manager] retain];
        forkManager.delegate = self;
        forkManager.successSelector = @selector(githubForkManager:resultsReadyForTask:);
        forkManager.failSelector = @selector(githubForkManager:failedForTask:);
        forkManager.maxConcurrentTasks = 3;
        
        SDGithubTask *networkTask = [SDGithubTask taskWithManager:forkManager];
        networkTask.type = SDGithubTaskGetRepoNetwork;
        networkTask.user = [userField stringValue];
        networkTask.repo = [[self.repositories objectAtIndex:index] valueForKey:@"name"];
        [networkTask run];
        
        self.isWaiting = YES;
    }
}


- (void) githubForkManager:(SDGithubTaskManager*)manager resultsReadyForTask:(SDGithubTask*)task {
	self.isWaiting = NO;
	self.forks = [task.results valueForKey:@"network"];
}

- (void) githubForkManager:(SDGithubTaskManager*)manager failedForTask:(SDGithubTask*)task {
	self.isWaiting = NO;
	
	self.forks = nil;
	
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"Error"];
	[alert setInformativeText:[task.error localizedDescription]];
	[alert runModal];
}

@end
