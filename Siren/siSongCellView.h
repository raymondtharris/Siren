//
//  siSongCellView.h
//  Siren
//
//  Created by Tim Harris on 5/12/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//
#import <Cocoa/Cocoa.h>
@class siButton;

@interface siSongCellView : NSTableCellView

@property (weak) IBOutlet NSImageView *albumArtImageView;
@property (weak) IBOutlet NSTextField *songName;
@property (weak) IBOutlet NSTextField *songArtistName;
@property (weak) IBOutlet NSTextField *songDuration;
@end
