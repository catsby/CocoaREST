//
//  AppDelegate.m
//  SDNet
//
//  Created by Steven Degutis on 5/27/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize isWaiting;
@synthesize results;

- (void) applicationDidFinishLaunching:(NSNotification*)notification {
	manager = [[SDTwitterTaskManager manager] retain];
	manager.delegate = self;
	manager.successSelector = @selector(twitterManager:resultsReadyForTask:);
	manager.failSelector = @selector(twitterManager:failedForTask:);
	manager.maxConcurrentTasks = 3;
}

- (IBAction) runTask:(id)sender {
	[self runUserTask];
}

- (void) runUserTask {
	manager.username = [userField stringValue];
	manager.password = [passField stringValue];
	
	SDTwitterTask *basicTask = [SDTwitterTask taskWithManager:manager];
	basicTask.type = [[taskTypeButton selectedItem] tag];
	[basicTask run];
	
	self.isWaiting = YES;
}

- (IBAction) findImage:(id)sender {
	NSOpenPanel *imagePanel = [NSOpenPanel openPanel];
	NSArray *imageTypes = [NSArray arrayWithObjects:@"gif", @"jpg", @"png", nil];
	
	// Only allow a single file to be chosen
	[imagePanel setCanChooseFiles:YES];
	[imagePanel setCanChooseDirectories:NO];
	[imagePanel setAllowsMultipleSelection:NO];
	
	// Display the sheet and only allow valid Twitter profile image types (gif, png, jpg)
	if ([imagePanel runModalForTypes:imageTypes] == NSOKButton) {
		[self changeTwitterProfileImage:[[imagePanel filenames] objectAtIndex:0]];
	}
}

- (void) changeTwitterProfileImage:(NSString *)imagePath {
	NSLog(@"New image path: %@", imagePath);
	NSLog(@"New image size: %@K", [self getImageSize:imagePath]);
	
	// Verify the image size is under the 700K limit
	
	// Change the profile image
	
/*	manager.successSelector = @selector(twitterManager:resultsReadyForChangeProfileImageTask:);
	
	SDTwitterTask *changeImageTask = [SDTwitterTask taskWithManager:manager];
	changeImageTask.type = SDTwitterTaskUpdateProfileImage;
	
	NSImage *newImage = [[[NSImage alloc] initWithContentsOfFile:imagePath] autorelease];

	changeImageTask.imageToUpload = newImage;
	
	[changeImageTask run]; */
}

- (NSNumber *) getImageSize:(NSString *)imagePath {
	unsigned long long size = 0;
	NSFileManager * fm = [NSFileManager defaultManager];
	NSDictionary *fattrs = [fm fileAttributesAtPath:imagePath traverseLink:NO];
	
	size = [[fattrs objectForKey:NSFileSize] unsignedLongLongValue];
	
	return [NSNumber numberWithUnsignedLongLong:size / 1024];
}
	
- (void) tableViewSelectionDidChange:(NSNotification *)notification {
	// Only enable the "Change..." button when the user selected is the
	// currently logged in user.
	if ([[manager username] isEqualToString:[userLabel stringValue]]) {
		[changeButton setEnabled:YES];
	} else {
		[changeButton setEnabled:NO];
	}
}

- (void) twitterManager:(SDTwitterTaskManager*)manager resultsReadyForTask:(SDTwitterTask*)task {
	self.isWaiting = NO;
	
	self.results = task.results;
}

- (void) twitterManager:(SDTwitterTaskManager*)manager failedForTask:(SDTwitterTask*)task {
	self.isWaiting = NO;
	
	self.results = nil;
	
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"Error"];
	[alert setInformativeText:[task.error localizedDescription]];
	[alert runModal];
}

@end
