//
//  siAppDelegate.h
//  Siren
//
//  Created by Tim Harris on 4/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "siSiren.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "siSongSuggestion.h"
#import "siPlayerInfoView.h"
#import "siMediaButton.h"


@interface siAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) MLMediaLibrary *library;
@property (weak) IBOutlet siPlayerInfoView *songPlayerView;

@property (nonatomic, strong) siSiren * userSiren;
@property (strong, nonatomic) IBOutlet NSArrayController *songsController;
@property (strong, nonatomic) IBOutlet NSArrayController *upNextController;

@property (strong) AVAudioPlayer * audioPlayer;
//@property (strong) AVPlayer *audioPlayer;

- (IBAction)clickPlayPauseButton:(id)sender;


- (IBAction)suggestSong:(id)sender;

@property (weak) IBOutlet NSTableView *suggestedSongView;
@property (weak) IBOutlet NSTableView *songsView;

- (IBAction)playSong:(id)sender;
- (IBAction)playNext:(id)sender;
- (IBAction)removeSong:(id)sender;


- (IBAction)playSongFromAllSongs:(id)sender;
- (IBAction)AddToUpNextAndPlayNext:(id)sender;

@property NSNumber *maxRating;
@property BOOL isStarted, isSorted;
- (IBAction)nextSong:(id)sender;

@property NSTimer *currentSongTimer;
@property NSTimer *votingStatusTimer;

@property (weak) IBOutlet NSSearchField *songSearchBar;
- (IBAction)searchSongs:(id)sender;

@property (weak) IBOutlet siMediaButton *playPauseButton;
@property (weak) IBOutlet siMediaButton *nextButton;


@property BOOL votingLocked;

@end
