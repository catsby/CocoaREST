//
//  SDGithubTask.m
//  CocoaREST
//
//  Created by Clint Shryock on 3/6/10.
//  Copyright 2010. All rights reserved.
//

#import "SDGithubTask.h"

#import "SDGithubTaskManager.h"

#import "SDNetTask+Subclassing.h"

@implementation SDGithubTask

@synthesize user;
@synthesize repo;


- (id) initWithManager:(SDGithubTaskManager*)newManager {
	if (self = [super initWithManager:newManager]) {
		githubManager = newManager;
		
		type = SDGithubTaskDoNothing;
		errorCode = SDNetTaskErrorNone;
	}
	return self;
}

// MARK: -
// MARK: Before-response Methods

- (BOOL) validateType {
	return (type > SDGithubTaskDoNothing && type < SDGithubTaskMAX);
}

//  Using each user's API Token in place of a password
- (BOOL) shouldUseBasicHTTPAuthentication {
	return YES;
}

- (BOOL) isMultiPartDataBasedOnTaskType {
	BOOL multiPartData = NO;
	
	return multiPartData;
}

- (SDHTTPMethod) methodBasedOnTaskType {
	SDHTTPMethod method = SDHTTPMethodGet;

	return method;
}

- (NSString*) URLStringBasedOnTaskType {
	NSString *URLStrings[SDGithubTaskMAX]; // is this a bad convention? no seriously, i dont know...
	
	URLStrings[SDGithubTaskGetRepos] = [NSString stringWithFormat:@"http://github.com/api/v2/json/repos/show/%@", githubManager.username];
	
	return URLStrings[type];
}

- (SDParseFormat) parseFormatBasedOnTaskType {
	// there may be some calls which return just a single string, without JSON formatting
	// if so, then we need to make this method conditional
	return SDParseFormatJSON;
}

- (void) sendResultsToDelegate {
    NSLog(@"sendResultsToDelegate in Github");
	if ([results isKindOfClass:[NSDictionary class]] && [[results allKeys] containsObject:@"error"]) {
		error = [NSError errorWithDomain:@"SDNetDomain" code:SDNetTaskErrorServiceDefinedError userInfo:nil];
		[self sendErrorToDelegate];
	}
	else
		[super sendResultsToDelegate];
}

- (void) dealloc {
	[user release], user = nil;
	[repo release], repo = nil;

    [super dealloc];
}
@end
