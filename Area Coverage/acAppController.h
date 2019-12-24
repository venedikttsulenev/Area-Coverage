#import <Foundation/Foundation.h>
#import "acDataProcessor.h"

@interface acAppController : NSObject {
    @private
    IBOutlet NSTextField *label;
    IBOutlet NSImageView *imageView;
    IBOutlet NSMenuItem *closeMenuItem;
    IBOutlet NSWindow *window;
}

- (void)processImage:(NSImage *)image;
- (IBAction)openFile:(id)sender;
- (IBAction)closeFile:(id)sender;

@end
