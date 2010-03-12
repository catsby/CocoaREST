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

@synthesize name;
@synthesize email;
@synthesize blog;
@synthesize company;
@synthesize location;


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
	return NO;
}

- (BOOL) isMultiPartDataBasedOnTaskType {
	BOOL multiPartData = NO;
	
	return multiPartData;
}

- (SDHTTPMethod) methodBasedOnTaskType {
	SDHTTPMethod method = SDHTTPMethodGet;
	switch (type) {
        case SDGithubTaskUserUpdate:
			method = SDHTTPMethodPost;
			break;
    }
    return method;
}

- (NSString*) URLStringBasedOnTaskType 
{
    switch (type) {
		case SDGithubTaskGetRepos:
            assert([user isNotEqualTo:@""]);
			return [NSString stringWithFormat:@"http://github.com/api/v2/json/repos/show/%@", user];
			break;
        case SDGithubTaskGetRepoNetwork:
            assert([user isNotEqualTo:@""]);
            assert([repo isNotEqualTo:@""]);
            return [NSString stringWithFormat:@"http://github.com/api/v2/json/repos/show/%@/%@/network", user, repo];
            break;
        case SDGithubTaskUserShow:
            assert([user isNotEqualTo:@""]);
            return [NSString stringWithFormat:@"http://github.com/api/v2/json/user/show/%@", user];
            break;
        case SDGithubTaskUserUpdate:    //  update by adding updating fields in addParametersToDictionary:
            assert([githubManager.password isNotEqualTo:@""]);
            assert([githubManager.username isNotEqualTo:@""]);
            return [NSString stringWithFormat:@"http://github.com/api/v2/json/user/show/%@", githubManager.username];
            break;            
    }
    return nil;
}

- (void) addParametersToDictionary:(NSMutableDictionary*)parameters 
{
    NSLog(@"adding parameters:");
    if(name)
		[parameters setObject:name forKey:@"name"];
	
	if(email)
		[parameters setObject:email forKey:@"email"];
    
    if(blog)
		[parameters setObject:name forKey:@"blog"];
	
	if(company)
		[parameters setObject:email forKey:@"company"];
    
	if(location)
		[parameters setObject:email forKey:@"location"];
    
    
	if(githubManager.username)
		[parameters setObject:githubManager.username forKey:@"login"];
    
	if(githubManager.password)
		[parameters setObject:githubManager.password forKey:@"token"];
}

- (SDParseFormat) parseFormatBasedOnTaskType {
	// there may be some calls which return just a single string, without JSON formatting
	// if so, then we need to make this method conditional
	return SDParseFormatJSON;
}

- (void) sendResultsToDelegate {
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
