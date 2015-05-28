//
//  siPlayerInfoView.h
//  Siren
//
//  Created by Tim Harris on 5/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface siPlayerInfoView : NSView


@property (weak) IBOutlet NSImageView * albumArtwork;
@property (weak) IBOutlet NSSlider * currentSongProgressSlider;
@property (weak) IBOutlet NSTextField * currentSongName;
@property (weak) IBOutlet NSTextField * currentSongArtist;
@property (weak) IBOutlet NSTextField * currentSongDuration;
@property (weak) IBOutlet NSTextField * currentSongCurrentTime;
@end
