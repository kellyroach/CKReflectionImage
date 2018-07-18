/**
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE":
 * The Cocoakit author wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return or, drink a beer in 
 * my honor.
 * ----------------------------------------------------------------------------
 */

#import "CKReflectionImage.h"

@implementation CKReflectionImage

#pragma mark -
#pragma mark Draw methods

/**
 * Draws the receiver’s image within the passed-in rectangle.
 * 
 * @param rect: The portion of the view’s bounds that needs to be updated.
 */
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (_image != nil) {
        
        // Get current context to draw.
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Reflection image references
        CGImageRef reflectionImage = NULL;
        CGImageRef gradientImage = NULL;
        
        // Frame of image
        CGRect frame = [self frame];
        frame.origin.x = 0.0f;
        frame.origin.y = 0.0f;
        frame.size.width = CGRectGetWidth(frame);
        frame.size.height = _image.size.height * CGRectGetWidth(frame) / _image.size.width;
        
        // Draw initial image in context
        CGContextSaveGState(context);
        {
            
            // Draw image in context, commented but the image show in reverse.
//            CGContextDrawImage(context, frame, [_image CGImage]);
            
            // Push context to draw image.
            UIGraphicsPushContext(context);
            
            // Draw original image in top
            [_image drawInRect:frame];
            
            // Pop to context
            UIGraphicsPopContext();
            
        }
        CGContextRestoreGState(context);
        
        // Create gradient bitmap
        CGContextSaveGState(context);
        {
            
            // Gradient is always black-white and the mask must be in the gray colorspace.
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
            
            // Create a bitmap context
            CGContextRef gradientContext = CGBitmapContextCreate(NULL, CGRectGetWidth(frame), CGRectGetHeight(frame), 8, 0, colorSpace, kCGImageAlphaNone);
            
            // Define the start and the end grayscale values (with the alpha, even though our
            // bitmap context doesn't support alpha gradient requieres it).
            CGFloat colors[] = {0.0f, 1.0f, 1.0f, 1.0f};
            
            // Creates the CGGradient
            CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
            
            // Release colorSpace reference
            CGColorSpaceRelease(colorSpace);
            
            // Create the start and end points for the gradient vector (straight down).
            CGPoint gradientStartPoint = CGPointMake(0, (CGRectGetHeight(frame) - _visibleReflectionHeight));
            CGPoint gradientEndPoint = CGPointMake(0, ((CGRectGetHeight(frame) * 2) - _visibleReflectionHeight));
            
            // Draw gradient into gradient context.
            CGContextDrawLinearGradient(gradientContext, grayScaleGradient, gradientStartPoint, gradientEndPoint, kCGGradientDrawsAfterEndLocation);
            
            // Release Gradient reference.
            CGGradientRelease(grayScaleGradient);
            
            // Convert the gradient context to image.
            gradientImage = CGBitmapContextCreateImage(gradientContext);
            
            // Release gradient context
            CGContextRelease(gradientContext);
            
        }
        CGContextRestoreGState(context);
        
        // Apply gradient bitmap to new context that contains image.
        CGContextSaveGState(context);
        {
            
            // Create a RGB color space
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            
            // Create bitmap context to join image and gradient context.
            CGContextRef reflectionContext = CGBitmapContextCreate(NULL, CGRectGetWidth(frame), CGRectGetHeight(frame), 8, 0, colorSpace, (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast));
            
            // Release color space
            CGColorSpaceRelease(colorSpace);
            
            // First clip mask to context
            CGContextSaveGState(context);
            {
                
                // Clip gradient mask to reflection context.
                CGContextClipToMask(reflectionContext, frame, gradientImage);
                
            }
            CGContextRestoreGState(context);
            
            // Second draw image to context
            CGContextSaveGState(reflectionContext);
            {
                
                // Push context to draw image.
                UIGraphicsPushContext(reflectionContext);
                
                // Draw original image in top
                [_image drawInRect:frame];
                
                // Pop to context
                UIGraphicsPopContext();
                
            }
            CGContextRestoreGState(reflectionContext);
            
            // Delete gradient image mask
            CGImageRelease(gradientImage);
            
            // Convert reflection context to image.
            reflectionImage = CGBitmapContextCreateImage(reflectionContext);
            
            // Release reflection context
            CGContextRelease(reflectionContext);
            
        }
        CGContextRestoreGState(context);
        
        // Transform matrix and draw reflection bitmap.
        CGContextSaveGState(context);
        {
            
            // Translate context matrix to height * 2 but next scale and sum 1.0f of image and padding.
            CGContextTranslateCTM(context, CGRectGetMinX(frame), (CGRectGetHeight(frame) * 2) + _paddingToTopImage);
            
            // Flip vertical image in context.
            CGContextScaleCTM(context, 1.0f, -1.0f);
            
            // Draw reflection image in context.
            CGContextDrawImage(context, frame, reflectionImage);
            
            // Release reflectio image.
            CGImageRelease(reflectionImage);
            
        }
        CGContextRestoreGState(context);
        
    }
    
}

/**
 * Set current image to another image.
 *
 * @param image: Another image to set.
 */
- (void)setImage:(UIImage *)image {
    _image = image;
    [self setNeedsDisplay];
}

/**
 * Set current visibleReflectioHeight_ value to another.
 *
 * @param gradientStart: Another value to visible reflectio height variable.
 */
- (void)setVisibleReflectionHeight:(CGFloat)visibleReflectioHeight {
    
    if (_visibleReflectionHeight != visibleReflectioHeight) {
        
        _visibleReflectionHeight = visibleReflectioHeight;
        
    }
    
    [self setNeedsDisplay];
    
}

/**
 * Set current paddingToTopImage variable to another value.
 *
 * @param paddingToTopImage: Another value to padding to top image.
 */
- (void)setPaddingToTopImage:(CGFloat)paddingToTopImage {
    
    if (_paddingToTopImage != paddingToTopImage) {
        
        _paddingToTopImage = paddingToTopImage;
        
    }
    
    [self setNeedsDisplay];
    
}

@end
