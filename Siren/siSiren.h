//
//  siSiren.h
//  Siren
//
//  Created by Tim Harris on 4/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaLibrary/MediaLibrary.h>
@class siSongSuggestion;

typedef NS_ENUM(NSInteger, sirenIncrement){
    sirenIncrementSingle = 1,
    sirenIncrementMax = 100001
};

extern NSString * const SongsFinishedLoadingNotification;

@interface siSiren : NSObject

@property (strong, nonatomic) NSString * sirenName;
@property (strong, nonatomic) NSNumber * sirenUserListCount, *sirenSongsCount, *sirenAlbumCount;

@property MLMediaLibrary * sirenMediaLibrary;
@property MLMediaSource *sirenSource;
@property MLMediaGroup *sirenMusicGroup, *sirenRootMediaGroup;
@property NSDictionary *sourceDictionary;
@property NSMutableArray *upNext, *songs;

-(id)init;
-(void)loadLibrary;

@end

@interface siSiren (upNext)
-(void)addToUpNext:(siSongSuggestion*) newSongSuggestion;
-(void)addToUpNext:(siSongSuggestion*) newSongSuggestion withIncrement:(sirenIncrement) increment;

-(void)sortUpNext;
@end