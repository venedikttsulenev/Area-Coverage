#import "acAppController.h"

@implementation acAppController

- (void)awakeFromNib {
    [[closeMenuItem menu] setAutoenablesItems:NO];
    [closeMenuItem setEnabled:NO];
}

- (void)processImage:(NSImage *)image {
    [[imageView window] setIsVisible:YES];
    [imageView setImage:image];
    
    double blackPercentage = [acDataProcessor processImage:image];
    [label setStringValue:
     [NSString stringWithFormat:@"%.1lf %%", blackPercentage]];
}

- (IBAction)openFile:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    if (NSOKButton == [openPanel runModal]) {
        NSString *path = [(NSURL *)[[openPanel URLs] objectAtIndex:0] path];
        [[imageView window] setTitle:
         [NSString stringWithFormat:@"Area Coverage [%@]", [path lastPathComponent]]];
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
        [imageView setImage:image];

        [self processImage:image];
        [closeMenuItem setEnabled:YES];
    }
}

- (IBAction)closeFile:(id)sender {
    [imageView setImage:nil];
    [closeMenuItem setEnabled:NO];
    [[imageView window] performClose:self];
}

@end
