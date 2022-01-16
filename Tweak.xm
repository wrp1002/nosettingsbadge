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

//	=========================== Hooks ===========================


%hook SBApplication
	-(id)badgeValue {
		if ([[self bundleIdentifier] isEqualToString:@"com.apple.Preferences"])
			return nil;
		return %orig;
	}
%end

%ctor {
	[Debug Log:[NSString stringWithFormat:@"============== %@ started ==============", TWEAK_NAME]];
}
