//
//  siSiren.m
//  Siren
//
//  Created by Tim Harris on 4/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siSiren.h"
#import "siSongSuggestion.h"





@interface siSiren (sorting)
-(void)quickSort:(NSMutableArray*) Arr withFirst:(int) first andLast:(int)last;
-(int) partition:(NSMutableArray*) Arr withFirst:(int) first andLast:(int) last;

@end

static NSString *const	kMediaSourcesContext = @"mediaSources";
static NSString *const	kMediaGroupContext = @"rootMediaGroup";
static NSString *const	kMediaMusicContext = @"mediaObjects";

@implementation siSiren

NSString * const SongsFinishedLoadingNotification = @"SongsFinishedLoadingNotification";


-(id)init
{
    self = [super init];
   
    if (self) {
        _upNext = [[NSMutableArray alloc] init];
        _songs =[[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)loadLibrary
{
     NSDictionary *dict = @{MLMediaLoadSourceTypesKey: @(MLMediaSourceTypeAudio), MLMediaLoadIncludeSourcesKey: @[MLMediaSourceiTunesIdentifier]};
    _sirenMediaLibrary = [[MLMediaLibrary alloc] initWithOptions:dict];
    _sourceDictionary = _sirenMediaLibrary.mediaSources;
    [_sirenMediaLibrary addObserver:self forKeyPath:@"mediaSources" options:0 context:(void*)CFBridgingRetain(kMediaSourcesContext)];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"%@",context);
    if (context == CFBridgingRetain(kMediaSourcesContext)) {
        _sirenSource = [_sirenMediaLibrary.mediaSources objectForKey:@"com.apple.iTunes"];
        _sirenRootMediaGroup = [_sirenSource rootMediaGroup];
        [_sirenSource addObserver:self forKeyPath:@"rootMediaGroup" options:0 context:(void*)CFBridgingRetain(kMediaGroupContext)];
    }else if (context == CFBridgingRetain(kMediaGroupContext)){
        _sirenMusicGroup =_sirenSource.rootMediaGroup.childGroups[0];
        _songs = [NSMutableArray arrayWithArray:_sirenMusicGroup.mediaObjects];
        [_sirenMusicGroup addObserver:self forKeyPath:@"mediaObjects" options:0 context:(void*)CFBridgingRetain(kMediaMusicContext)];
    }else if (context == CFBridgingRetain(kMediaMusicContext)){
        _songs = [NSMutableArray arrayWithArray:_sirenMusicGroup.mediaObjects];
        _sirenSongsCount = [NSNumber numberWithUnsignedInteger: _songs.count];
        [[NSNotificationCenter defaultCenter] postNotificationName:SongsFinishedLoadingNotification object:self];
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)addToUpNext:(siSongSuggestion *)newSongSuggestion
{
    BOOL found = NO;
    for (siSongSuggestion *song in _upNext) {
        if (song.song == newSongSuggestion.song) {
            found = YES;
            [song incrementRatingsCount];
        }
    }
    if (!found) {
        [_upNext addObject:newSongSuggestion];
    }
}
-(void)addToUpNext:(siSongSuggestion*) newSongSuggestion withIncrement:(sirenIncrement) increment
{
    BOOL found = NO;
    for (siSongSuggestion *song in _upNext) {
        if (song.song == newSongSuggestion.song) {
            found = YES;
            [song setRatingCount:[NSNumber numberWithInt:[song.ratingCount intValue]+ increment]];
        }
    }
    if (!found) {
        [newSongSuggestion setRatingCount:[NSNumber numberWithInt:increment]];
        [_upNext addObject:newSongSuggestion];
    }
}
-(void) sortUpNext
{
    [self quickSort:_upNext withFirst:1 andLast:(int)_upNext.count];
    
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

@end
