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
@synthesize results;

- (void) awakeFromNib
{
	manager = [[SDGithubTaskManager manager] retain];
	manager.delegate = self;
	manager.successSelector = @selector(githubManager:resultsReadyForTask:);
	manager.failSelector = @selector(githubManager:failedForTask:);
	manager.maxConcurrentTasks = 3;
}

- (IBAction) findImage:(id)sender {}

- (IBAction) runTask:(id)sender {
	manager.username = [userField stringValue];
	manager.password = [apiTokenField stringValue];
	
	SDGithubTask *basicTask = [SDGithubTask taskWithManager:manager];
	basicTask.type = [[taskTypeButton selectedItem] tag];
	[basicTask run];
	
	self.isWaiting = YES;
}

- (void) githubManager:(SDGithubTaskManager*)manager resultsReadyForTask:(SDGithubTask*)task {
	self.isWaiting = NO;
	//NSLog(@"results:\n%@", task.results);
	self.results = [task.results valueForKey:@"repositories"];
    NSLog(@"results:\n%@", self.results);
    NSLog(@"results class: %@", [self.results class]);
}

- (void) githubManager:(SDGithubTaskManager*)manager failedForTask:(SDGithubTask*)task {
	self.isWaiting = NO;
	
	self.results = nil;
	
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"Error"];
	[alert setInformativeText:[task.error localizedDescription]];
	[alert runModal];
}

@end
