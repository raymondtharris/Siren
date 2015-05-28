//
//  siSuggestionSongCellView.h
//  Siren
//
//  Created by Tim Harris on 5/11/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface siSuggestionSongCellView : NSTableCellView

@property (weak) IBOutlet NSTextField *songName;
@property (weak) IBOutlet NSTextField *rankCount;
@property NSColor *strokeColor;
@end
