//
//  SDTwitterTask.h
//  SDNet
//
//  Created by Steven Degutis on 5/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDNetTask.h"

@class SDTwitterTaskManager;

typedef enum _SDTwitterTaskType {
	SDTwitterTaskDoNothing,
	
	SDTwitterTaskGetPublicTimeline,
	SDTwitterTaskGetPersonalTimeline,
	SDTwitterTaskGetUsersTimeline,
	SDTwitterTaskGetMentions,
	
	SDTwitterTaskGetStatus,
	SDTwitterTaskCreateStatus,
	SDTwitterTaskDeleteStatus,
	
	SDTwitterTaskGetUserInfo,
	SDTwitterTaskGetUsersFriends,
	SDTwitterTaskGetUsersFollowers,
	
	SDTwitterTaskGetReceivedDirectMessages,
	SDTwitterTaskGetSentDirectMessages,
	SDTwitterTaskCreateDirectMessage,
	SDTwitterTaskDeleteDirectMessage,
	
	SDTwitterTaskFollowUser,
	SDTwitterTaskUnfollowUser,
	SDTwitterTaskCheckIfUserFollowsUser,
	
	SDTwitterTaskGetIDsOfFriends,
	SDTwitterTaskGetIDsOfFollowers,
	
	SDTwitterTaskVerifyCredentials,
	SDTwitterTaskUpdateDeliveryDevice,
	SDTwitterTaskUpdateProfileColors,
	SDTwitterTaskUpdateProfileImage, // broken for the moment
	SDTwitterTaskUpdateProfileBackgroundImage, // broken for the moment
	SDTwitterTaskUpdateProfile,
	
	SDTwitterTaskGetFavoriteStatuses,
	SDTwitterTaskFavorStatus,
	SDTwitterTaskUnavorStatus,
	
	SDTwitterTaskEnableDeviceNotificationsFromUser,
	SDTwitterTaskDisableDeviceNotificationsFromUser,
	
	SDTwitterTaskBlockUser,
	SDTwitterTaskUnblockUser,
	SDTwitterTaskCheckIfBlockingUser,
	SDTwitterTaskGetBlockedUsers,
	SDTwitterTaskGetBlockedUserIDs,
	
	SDTwitterTaskSearch,
	SDTwitterTaskTrends,
	SDTwitterTaskGetRateLimitStatus,
	SDTwitterTaskGetUserInfoUsingYQL,

	SDTwitterTaskMAX // NEVER use this value (srsly... kthxbye)
} SDTwitterTaskType;

typedef enum _SDTwitterDeviceType {
	SDTwitterDeviceTypeNotYetSet,
	SDTwitterDeviceTypeSMS,
	SDTwitterDeviceTypeInstantMessage,
	SDTwitterDeviceTypeNone
} SDTwitterDeviceType;

@interface SDTwitterTask : SDNetTask {
	SDTwitterTaskManager *twitterManager;
	
	int cursor;
	int count;
	int page;
	int rpp;
	
	NSString *text;
	
	NSString *q;
	NSString *ands;
	NSString *phrase;
	NSString *ors;
	NSString *nots;
	NSString *from;
	NSString *to;
	NSString *tude;
	NSString *since_id;
	NSString *format;

	NSString *olderThanStatusID;
	NSString *newerThanStatusID;
	NSString *inReplyToStatusID;
	
	NSString *firstUsersID;
	NSString *secondUsersID;
	
	NSString *statusID;
	NSString *userID;
	NSString *screenName;
	NSString *screenNameOrUserID;
	
	NSString *profileName;
	NSString *profileEmail;
	NSString *profileWebsite;
	NSString *profileLocation;
	NSString *profileDescription;
	
	NSColor *profileBackgroundColor;
	NSColor *profileTextColor;
	NSColor *profileLinkColor;
	NSColor *profileSidebarFillColor;
	NSColor *profileSidebarBorderColor;
	
	BOOL enableDeviceNotificationsAlso;
	SDTwitterDeviceType deviceType;
	
	BOOL shouldTileBackgroundImage;
	NSURL *imageToUpload;
}

- (id) copyWithNextPage;

// writable properties: set up before running

@property int cursor;
@property int count;
@property int page;
@property int rpp;

@property (copy) NSString *text;

@property (copy) NSString *callback;
@property (copy) NSString *gcontext;
@property (copy) NSString *langpair;
@property (copy) NSString *key;
@property (copy) NSString *v;

@property (copy) NSString *q;
@property (copy) NSString *ands;
@property (copy) NSString *phrase;
@property (copy) NSString *ors;
@property (copy) NSString *nots;
@property (copy) NSString *from;
@property (copy) NSString *to;
@property (copy) NSString *tude;

@property (copy) NSString *since_id;
@property (copy) NSString *format;

@property (copy) NSString *olderThanStatusID;
@property (copy) NSString *newerThanStatusID;
@property (copy) NSString *inReplyToStatusID;

@property (copy) NSString *firstUsersID;
@property (copy) NSString *secondUsersID;

@property (copy) NSString *statusID;
@property (copy) NSString *userID;
@property (copy) NSString *screenName;
@property (copy) NSString *screenNameOrUserID;

@property (copy) NSString *profileName;
@property (copy) NSString *profileEmail;
@property (copy) NSString *profileWebsite;
@property (copy) NSString *profileLocation;
@property (copy) NSString *profileDescription;

@property (copy) NSColor *profileBackgroundColor;
@property (copy) NSColor *profileTextColor;
@property (copy) NSColor *profileLinkColor;
@property (copy) NSColor *profileSidebarFillColor;
@property (copy) NSColor *profileSidebarBorderColor;

@property BOOL enableDeviceNotificationsAlso;
@property SDTwitterDeviceType deviceType;

@property BOOL shouldTileBackgroundImage;
@property (copy) NSURL *imageToUpload;

@end
