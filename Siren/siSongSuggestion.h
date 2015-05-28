//
//  siSongSuggestion.h
//  Siren
//
//  Created by Tim Harris on 4/25/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaLibrary/MediaLibrary.h>

@interface siSongSuggestion : NSObject
@property NSNumber * ratingCount;
@property (strong) MLMediaObject *song;

-(id)initWithSong:(MLMediaObject*) newSong;
-(void) incrementRatingsCount;
-(void) incrementRatingsCountWithValue:(int) value;
@end
