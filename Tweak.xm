//	=========================== Classes / Functions ===========================


@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString *bundleIdentifier;
-(NSString *)bundleIdentifier;
@end

@interface SBApplicationIcon
-(id)application;
@end


//	=========================== Hooks ===========================

%hook SBIconBadgeView
	-(void)configureForIcon:(id)arg1 infoProvider:(id)arg2 {
		NSString *bundleId = [[arg1 application] bundleIdentifier];
		if ([bundleId isEqualToString:@"com.apple.Preferences"])
			return;

		%orig;
	}
%end

