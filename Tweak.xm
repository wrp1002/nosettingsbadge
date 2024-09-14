#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define TWEAK_NAME @"NoSettingsBadge"

@interface Debug : NSObject
	+(void)Log:(NSString *)msg;
@end

@implementation Debug
	//	Show log with tweak name as prefix for easy grep
	+(void)Log:(NSString *)msg {
		NSLog(@"%@: %@", TWEAK_NAME, msg);
	}
@end


//	=========================== Classes / Functions ===========================

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString *bundleIdentifier;
@end

@interface PSSpecifier : NSObject
@property (nonatomic,retain) NSString *identifier;
@end

@interface PSBadgedTableCell
@property (nonatomic,retain) PSSpecifier *specifier;
@end


//	=========================== Hooks ===========================


%hook SBApplication
	-(id)badgeValue {
		if ([[self bundleIdentifier] isEqualToString:@"com.apple.Preferences"])
			return nil;

		return %orig;
	}
%end

%hook PSBadgedTableCell
	-(void)badgeWithInteger:(NSInteger)badgeValue {
		NSString *identifier = [self specifier].identifier;

		if ([identifier isEqualToString:@"General"] || [identifier isEqualToString:@"SOFTWARE_UPDATE_LINK"])
			badgeValue = 0;

		%orig(badgeValue);
	}
%end

%ctor {
	[Debug Log:[NSString stringWithFormat:@"============== %@ started ==============", TWEAK_NAME]];
}
