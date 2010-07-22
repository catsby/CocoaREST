//
//  NSColor+HexAdditions.m
//  SDNet
//
//  Created by Steven Degutis on 5/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "NSColor+Hex.h"

// taken from http://developer.apple.com/qa/qa2007/qa1576.html and made to not suck.

@implementation NSColor (Hex)

- (NSString*) hexValue {
	NSColor *convertedColor = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	if (convertedColor == nil)
		return nil;
	
	CGFloat redCGFloatValue, greenCGFloatValue, blueCGFloatValue;
	[convertedColor getRed:&redCGFloatValue green:&greenCGFloatValue blue:&blueCGFloatValue alpha:NULL];
	
	int redIntValue = redCGFloatValue * 255.99999f;
	int greenIntValue = greenCGFloatValue * 255.99999f;
	int blueIntValue = blueCGFloatValue * 255.99999f;
	
	return [NSString stringWithFormat:@"#%02x%02x%02x", redIntValue, greenIntValue, blueIntValue];
}

@end
