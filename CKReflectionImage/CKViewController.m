/**
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE":
 * The Cocoakit author wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return or, drink a beer in 
 * my honor.
 * ----------------------------------------------------------------------------
 */

#import "CKViewController.h"

#import "CKReflectionImage.h"

/**
 * Defines a NIB file name.
 */
#define NIB_FILE_NAME                                               @"CKViewController"

@implementation CKViewController

#pragma mark - View lifecycle

/**
 * Called after the controller’s view is loaded into memory.
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    reflectionImage = [[CKReflectionImage alloc] initWithFrame:CGRectMake(96, 20, 128, 257)];
    
    [reflectionImage setBackgroundColor:[UIColor clearColor]];
    
    [reflectionImage setPaddingToTopImage:2.0f];
    
    // Hide 1/4 parts of image. show 3/4
    [reflectionImage setVisibleReflectionHeight:(CGRectGetWidth([reflectionImage frame]) / 4 * 3)];
    
    [reflectionImage setImage:[UIImage imageNamed:@"apple-logo.png"]];
    
    [[self view] addSubview:reflectionImage];
    
}

#pragma mark - Instances initialization

/*
 * Create and return an autoreleased CKViewController contructed from NIB file.
 */
+ (CKViewController *)ckViewController {
  
    return [[CKViewController alloc] initWithNibName:NIB_FILE_NAME bundle:nil];
    
}

@end
