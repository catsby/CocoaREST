//
//  GithubDelegate.h
//  CocoaREST
//
//  Created by Clint Shryock on 3/6/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDGithubTaskManager.h"

@interface GithubDelegate : NSObject {

	SDGithubTaskManager *manager;
	
	BOOL isWaiting;
	NSArray *results;
	
	IBOutlet NSTableView *resultsView;
	IBOutlet NSTextField *userField;
	IBOutlet NSTextField *userLabel;
	IBOutlet NSTextField *apiTokenField;
	IBOutlet NSPopUpButton *taskTypeButton;
	IBOutlet NSImageView *profileImageView;
}

@property BOOL isWaiting;
@property (copy) NSArray *results;

- (IBAction) runTask:(id)sender;
- (IBAction) findImage:(id)sender;

@end
