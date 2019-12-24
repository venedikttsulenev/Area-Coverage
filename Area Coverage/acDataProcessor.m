#import "acDataProcessor.h"

@implementation acDataProcessor

struct pixel_s {
    uint8_t r, g, b, a;
};

/* Returns percentage of black color for image */
+ (double)processImage:(NSImage *)image {
    NSInteger width = [image size].width;
    NSInteger height = [image size].height;
    NSUInteger black = 0, white = 0;
    
    NSBitmapImageRep *bitmapRepRGBA32 = [[NSBitmapImageRep alloc]
                                         initWithBitmapDataPlanes:NULL
                                         pixelsWide:width
                                         pixelsHigh:height
                                         bitsPerSample:8
                                         samplesPerPixel:4
                                         hasAlpha:YES
                                         isPlanar:NO
                                         colorSpaceName:NSCalibratedRGBColorSpace
                                         bytesPerRow:width * 4
                                         bitsPerPixel:32];
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep:bitmapRepRGBA32];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:context];
    [image drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    
    struct pixel_s *pix = (struct pixel_s *)[bitmapRepRGBA32 bitmapData];
    for (NSInteger y = 0; y < height; ++y)
        for (NSInteger x = 0; x < width; ++x)
        {
            white += pix->r;
            ++pix;
        }
    
    [NSGraphicsContext restoreGraphicsState];
    NSUInteger total = width * height * 255;
    black = total - white;
    return (double) (black * 100) / total;
}

@end
