//
//  siAppDelegate.m
//  Siren
//
//  Created by Tim Harris on 4/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siAppDelegate.h"
#import "siSuggestionSongCellView.h"
#import "siSongCellView.h"
@interface siAppDelegate () <NSTableViewDataSource, NSTableViewDelegate, NSMenuDelegate, AVAudioPlayerDelegate>
@property NSPredicate *searchPredicate;
-(void)sortUpNext;
-(NSString *)formatDoubleForTime:(double) inputTime;
@end

@interface siAppDelegate (sorting)
-(void)quickSort:(NSMutableArray*) Arr withFirst:(int) first andLast:(int)last;
-(int) partition:(NSMutableArray*) Arr withFirst:(int) first andLast:(int) last;


@end

@implementation siAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _userSiren = [[siSiren alloc] init];
    
    [_userSiren loadLibrary];
    [_nextButton setMediaState:@"next"];
    
    _votingLocked = false;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadDataWithSongs:) name:SongsFinishedLoadingNotification object:nil];

    [_songSearchBar.cell setPlaceholderString:@"Search Songs"];
    _searchPredicate = [NSPredicate predicateWithFormat:@"(name contains[cd] $value) or (attributes.Artist contains[cd] $value) or (attributes.Album contains[cd] $value)"];
    _isStarted  = NO;
}

-(void)ReloadDataWithSongs:(NSNotification *)notification
{
    _songsController = [[NSArrayController alloc] initWithContent:_userSiren.songs];
    [_songsView reloadData];
    [_playPauseButton setMediaState:@"play"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if(tableView == _suggestedSongView){
       return _userSiren.upNext.count;
    }
    else if (tableView == _songsView){
        return [(NSMutableArray*)_songsController.content count];
    }
        return 0;
}
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView * cell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    MLMediaObject * song = [_songsController.content objectAtIndex:row];

    if ([tableColumn.identifier isEqualToString:@"Song"]) {
        cell.textField.stringValue = song.name;
        cell.textField.backgroundColor = [NSColor blueColor];
    }
    else if ([tableColumn.identifier isEqualToString:@"Artist"]){
        cell.textField.stringValue = [song.attributes objectForKey:@"Artist"];
    }
    else if ([tableColumn.identifier isEqualToString:@"Art"]){
        cell.imageView.image = song.artworkImage;

    }
    else if ([tableColumn.identifier isEqualToString:@"SiSong"]){
        siSongCellView *songCell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
        songCell.albumArtImageView.image = song.artworkImage;
        songCell.songName.stringValue  = song.name;
        songCell.songArtistName.stringValue = [song.attributes objectForKey:@"Artist"];
        return songCell;
    }
    
    else if ([tableColumn.identifier isEqualToString:@"SongSuggestion"]){
        siSuggestionSongCellView * suggestioncell = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
        siSongSuggestion * songSug = [_userSiren.upNext objectAtIndex:row];
        
        suggestioncell.songName.stringValue  = songSug.song.name;
        suggestioncell.rankCount.stringValue = [songSug.ratingCount stringValue];
        
        switch (row) {
            case 0:
                [suggestioncell setStrokeColor:[NSColor colorWithCalibratedRed:255.0/255.0 green:215.0/255.0 blue:0.0/255.0 alpha:1.0]];
                break;
            case 1:
                [suggestioncell setStrokeColor:[NSColor colorWithCalibratedRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0]];
                break;
            case 2:
                [suggestioncell setStrokeColor:[NSColor colorWithCalibratedRed:205.0/255.0 green:127.0/255.0 blue:50.0/255.0 alpha:1.0]];
                break;
            default:
               [suggestioncell setStrokeColor:[NSColor colorWithCalibratedRed:135.0/255.0 green:206.0/255.0 blue:255.0/255.0 alpha:1.0]];
                break;
        }
        
        return  suggestioncell;
    }
    
    return cell;
}
-(NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes
{
    return proposedSelectionIndexes;
}
-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    //NSLog(@"%@",notification);
}

-(void)songTimer:(NSTimer*) timer
{
    _songPlayerView.currentSongProgressSlider.doubleValue  = _audioPlayer.currentTime;
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"mm:ss";
    _songPlayerView.currentSongCurrentTime.stringValue = [self formatDoubleForTime:_audioPlayer.currentTime];
}

-(void)votingStatusCheck:(NSTimer*) timer{
    if (!_votingLocked) {
        if (_audioPlayer.currentTime >= (_audioPlayer.duration - 4.0)) {
            _votingLocked = true;
            
            // Broadcast votingLock to users
            
        }
    }
}

- (void)togglePlayback
{
    if (_audioPlayer.url!=nil) {
        if (_audioPlayer.playing) {
            [_audioPlayer pause];
            [_currentSongTimer invalidate];
            _currentSongTimer = nil;
            [_playPauseButton setMediaState:@"play"];
            //_PlayPauseButton.title = @"Play";
        }else{
            [_audioPlayer play];
            _currentSongTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(songTimer:) userInfo:nil repeats:YES];
            _votingStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(votingStatusCheck:) userInfo:nil repeats:YES];
            [_playPauseButton setMediaState:@"pause"];
            //_PlayPauseButton.title = @"Pause";
        }
    }
}

- (IBAction)suggestSong:(id)sender
{
    if (!_votingLocked) {
        MLMediaObject *song =_songsController.content[(long)[_songsView rowForView: [sender superview]]];
        siSongSuggestion *suggestion  = [[siSongSuggestion alloc] initWithSong:song];
        [_userSiren addToUpNext:suggestion withIncrement:sirenIncrementSingle];
        
        [_suggestedSongView reloadData];
    }
}


- (IBAction)playSong:(id)sender
{
    //NSLog(@"%ld", (long)[_suggestedSongView clickedRow]);
    MLMediaObject *song =[_userSiren.upNext[(long)[_suggestedSongView clickedRow]] song];
    
    NSURL * songURL = [song URL];
    NSError *err = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songURL error:&err];
    //_audioPlayer = [[AVPlayer alloc] initWithURL:songURL];
    //_audioPlayer.delegate = self;
    [self setCurrentSongInfo:song];
    [self setUpSongPlaybackSlider];
    [self togglePlayback];
    [_userSiren.upNext removeObjectAtIndex:[_suggestedSongView clickedRow]];
    [_suggestedSongView reloadData];
    //[_audioPlayer play];
    
}

- (IBAction)playNext:(id)sender
{
    siSongSuggestion *song =_userSiren.upNext[(long)[_suggestedSongView clickedRow]];
    [song setRatingCount:[NSNumber numberWithInt:[[song ratingCount] intValue]+ sirenIncrementMax]];
    [self sortUpNext];
    if(_userSiren.upNext.count >1)
        [_userSiren.upNext[0] setRatingCount:[NSNumber numberWithInt: [[_userSiren.upNext[1] ratingCount] intValue]+1]];
    [_suggestedSongView reloadData];
    
}

- (IBAction)removeSong:(id)sender
{
    [_userSiren.upNext removeObjectAtIndex:[_suggestedSongView clickedRow]];
    [_suggestedSongView reloadData];
}
- (IBAction)playSongFromAllSongs:(id)sender
{
    [self AddToUpNextAndPlayNext:sender];
    if (!_isStarted) {
        _isStarted = YES;
    }
    [self nextSong:sender];
}

- (IBAction)AddToUpNextAndPlayNext:(id)sender
{
    MLMediaObject *song = _songsController.content[[_songsView clickedRow]];
    siSongSuggestion *suggestion = [[siSongSuggestion alloc] initWithSong:song];
    [_userSiren addToUpNext:suggestion withIncrement:sirenIncrementMax];
    [self sortUpNext];
    if(_userSiren.upNext.count >1)
        [_userSiren.upNext[0] setRatingCount:[NSNumber numberWithInt: [[_userSiren.upNext[1] ratingCount] intValue]+1]];
    else
        [_userSiren.upNext[0] setRatingCount:[NSNumber numberWithInt: 1]];
    [_suggestedSongView reloadData];
}

-(void) sortUpNext
{
    [self quickSort:_userSiren.upNext withFirst:1 andLast:(int)_userSiren.upNext.count];
    
}


-(void)quickSort:(NSMutableArray *)Arr withFirst:(int)first andLast:(int)last
{
    int mid;
    if (first <last) {
        mid = [self partition:Arr withFirst:first andLast:last];
        [self quickSort:Arr withFirst:first andLast:mid-1];
        [self quickSort:Arr withFirst:mid+1 andLast:last];
    }
}

-(int)partition:(NSMutableArray *)Arr withFirst:(int)first andLast:(int)last
{
    NSNumber *current  = [Arr[last-1] ratingCount];
    int i = first-1;
    for (int j = first; j<last; j++) {
        if ([[Arr[j-1] ratingCount] intValue] >= [current intValue]) {
            i=i+1;
            siSongSuggestion * tempSong;
            tempSong = Arr[i-1];
            Arr[i-1] = Arr[j-1];
            Arr[j-1] = tempSong;
        }
    }
    siSongSuggestion * tempSong;
    tempSong = Arr[i];
    Arr[i] = Arr[last-1];
    Arr[last-1] = tempSong;
    return i+1;
}

-(void)playThisSong:(MLMediaObject*) song
{
    NSError *err = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:song.URL error:&err];
    _audioPlayer.delegate = self;
    
}
-(void)setCurrentSongInfo:(MLMediaObject*) song
{
    _songPlayerView.albumArtwork.image = song.artworkImage;
    _songPlayerView.currentSongName.stringValue = song.name;
    _songPlayerView.currentSongArtist.stringValue = [song.attributes objectForKey:@"Artist"];
    if ((_audioPlayer.duration-(int)_audioPlayer.duration) >=0.5)
        _songPlayerView.currentSongDuration.stringValue = [self formatDoubleForTime:ceil(_audioPlayer.duration)];
    else
        _songPlayerView.currentSongDuration.stringValue = [self formatDoubleForTime:_audioPlayer.duration];
}

- (IBAction)clickPlayPauseButton:(id)sender
{
    if (!_isStarted) {
        _isStarted =YES;
        [self sortUpNext];
        [self playThisSong:[_userSiren.upNext[0] song]];
        [self togglePlayback];
        
        // Add unhide Slider
        [_songPlayerView.currentSongProgressSlider setHidden:NO];
        [self setCurrentSongInfo:[_userSiren.upNext[0] song]];
        [self setUpSongPlaybackSlider];
        [_userSiren.upNext removeObjectAtIndex:0];
        [_suggestedSongView reloadData];
    }else{
        [self togglePlayback];
    }
}
- (IBAction)nextSong:(id)sender
{
    if (_userSiren.upNext.count >0) {
        [self sortUpNext];
        [self playThisSong:[_userSiren.upNext[0] song]];
        [self togglePlayback];
        [self setCurrentSongInfo:[_userSiren.upNext[0] song]];
        [self setUpSongPlaybackSlider];
        [_userSiren.upNext removeObjectAtIndex:0];
        _votingLocked = false;
        [_suggestedSongView reloadData];
    }
}

-(void)setUpSongPlaybackSlider
{
    _songPlayerView.currentSongProgressSlider.maxValue = _audioPlayer.duration;
    
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_currentSongTimer invalidate];
    _currentSongTimer = nil;
    [self nextSong:nil];
}
-(NSString *)formatDoubleForTime:(double) inputTime
{
    NSNumber *doubleValue = [NSNumber numberWithDouble:inputTime];
    NSString *timeString;
    int hr  = 0;
    //NSLog(@"%d", hr);
    int min =  ([doubleValue intValue]-hr*3600)/60;
    int sec = [doubleValue intValue] - hr*3600 -min*60;
    
    if(hr>0)
        timeString = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hr, min, sec ];
    else
        timeString = [NSString stringWithFormat:@"%.2d:%.2d", min, sec ];
    return  timeString;
}

- (IBAction)searchSongs:(id)sender
{
    NSString *temp = [sender stringValue];
    NSPredicate *pred = nil;
    NSDictionary *dict  = @{@"value": temp};
    pred  = [self.searchPredicate predicateWithSubstitutionVariables:dict];
    if (![temp isEqualToString:@""]) {
        _songsController.content = [_userSiren.songs filteredArrayUsingPredicate:pred];
    }
    else{
        _songsController.content = _userSiren.songs;
    }
    [_songsController rearrangeObjects];
    
    [_songsView reloadData];
}
@end
