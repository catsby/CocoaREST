//
//  AppDelegate.h
//  SDNet
//
//  Created by Steven Degutis on 5/27/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDTwitterTaskManager.h"

@interface AppDelegate : NSObject {
	SDTwitterTaskManager *manager;
	
	BOOL isWaiting;
	NSArray *results;
	
	IBOutlet NSTableView *resultsView;
	IBOutlet NSTextField *userField;
	IBOutlet NSTextField *userLabel;
	IBOutlet NSTextField *passField;
	IBOutlet NSPopUpButton *taskTypeButton;
	IBOutlet NSImageView *profileImageView;
	IBOutlet NSButton *changeButton;
}

@property BOOL isWaiting;
@property (copy) NSArray *results;

- (IBAction) runTask:(id)sender;
- (IBAction) findImage:(id)sender;

- (void) runUserTask;
- (void) changeTwitterProfileImage:(NSString *)imagePath;
- (NSNumber *) getImageSize:(NSString *)imagePath;

@end
