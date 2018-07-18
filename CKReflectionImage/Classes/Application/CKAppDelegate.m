/**
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE":
 * The Cocoakit author wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return or, drink a beer in 
 * my honor.
 * ----------------------------------------------------------------------------
 */

#import "CKAppDelegate.h"

#import "CKViewController.h"

@implementation CKAppDelegate

#pragma mark - Properties

@synthesize window = _window;
@synthesize viewController = _viewController;

#pragma mark - Application methods

/**
 * Tells the delegate when the application has launched and may have additional launch options to handle.
 *
 * @param application: The delegating application object.
 * @param launchOptions: A dictionary indicating the reason the application was launched (if any).
 * @return NO if the application cannot handle the URL resource, otherwise return YES.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    [self setViewController:[CKViewController ckViewController]];
    
    [[self window] setRootViewController:[self viewController]];
    
    [[self window] makeKeyAndVisible];
    
    return YES;
    
}

@end
