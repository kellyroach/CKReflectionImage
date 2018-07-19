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

@interface CKViewController ()
/**
 * A reflection image example.
 */
@property (nonatomic, weak) IBOutlet CKReflectionImage* reflectionImage;
@end

@implementation CKViewController

#pragma mark - View lifecycle

/**
 * Called after the controller’s view is loaded into memory.
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [_reflectionImage setBackgroundColor:[UIColor clearColor]];
    [_reflectionImage setPaddingToTopImage:2.0f];
    // Hide 1/4 parts of image. show 3/4
    [_reflectionImage setVisibleReflectionHeight:(CGRectGetWidth([_reflectionImage frame])/4*3)];
    [_reflectionImage setImage:[UIImage imageNamed:@"apple-logo.png"]];
}

@end
