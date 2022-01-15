//	=========================== Classes / Functions ===========================


@interface SBIconBadgeView : UIView
@end

@interface SBIconView : UIView
@property (nonatomic,copy,readonly) NSString *applicationBundleIdentifierForShortcuts; 
@end


//	=========================== Hooks ===========================

%hook SBIconBadgeView
	-(void)layoutSubviews {
		UIView *parent = self.superview.superview.superview;
		NSString *className = NSStringFromClass([parent class]);

		if (![className isEqualToString:@"SBIconView"])
			return;

		SBIconView *icon = (SBIconView *)parent;
		NSString *bundleId = icon.applicationBundleIdentifierForShortcuts;

		if ([bundleId isEqualToString:@"com.apple.Preferences"])
			[self setHidden:YES];

		%orig;
	}
%end

