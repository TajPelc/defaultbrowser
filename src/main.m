//  main.m
//  defaultbrowser
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NSString* get_app_name(NSString *bundleId) {
    return [[[bundleId componentsSeparatedByString:@"."] lastObject] lowercaseString];
}

int main(int argc, const char *argv[]) {
    const char *target = (argc == 1) ? NULL : argv[1];

    @autoreleasepool {
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        NSURL *testURL = [NSURL URLWithString:@"http://"];
        
        // Get all browsers
        NSMutableDictionary *browsers = [NSMutableDictionary dictionary];
        for (NSURL *appURL in [workspace URLsForApplicationsToOpenURL:testURL]) {
            NSString *bundleId = [[NSBundle bundleWithURL:appURL] bundleIdentifier];
            if (bundleId) {
                browsers[get_app_name(bundleId)] = bundleId;
            }
        }
        
        // Get current default browser
        NSURL *defaultAppURL = [workspace URLForApplicationToOpenURL:testURL];
        NSString *currentDefault = defaultAppURL ? get_app_name([[NSBundle bundleWithURL:defaultAppURL] bundleIdentifier]) : nil;

        if (target == NULL) {
            // List browsers
            for (NSString *name in browsers) {
                printf("%s%s\n", [name isEqualToString:currentDefault] ? "* " : "  ", [name UTF8String]);
            }
        } else {
            NSString *targetName = [NSString stringWithUTF8String:target];
            NSString *targetBundleId = browsers[targetName];

            if ([targetName isEqualToString:currentDefault]) {
                printf("%s is already the default browser\n", target);
            } else if (targetBundleId) {
                // Set as default for both HTTP and HTTPS
                for (NSString *scheme in @[@"http", @"https"]) {
                    LSSetDefaultHandlerForURLScheme(
                        (__bridge CFStringRef)scheme,
                        (__bridge CFStringRef)targetBundleId
                    );
                }
            } else {
                printf("%s is not available as a browser\n", target);
                return 1;
            }
        }
    }
    return 0;
}
