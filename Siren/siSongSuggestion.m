//
//  siSongSuggestion.m
//  Siren
//
//  Created by Tim Harris on 4/25/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siSongSuggestion.h"

@implementation siSongSuggestion

-(id)initWithSong:(MLMediaObject *)newSong{
    self = [super init];
    if (self) {
        _song = newSong;
        _ratingCount  = @1;
    }
    return self;
}
-(void)incrementRatingsCount
{
   _ratingCount = [NSNumber numberWithInt: [_ratingCount intValue] + 1];
}
-(void) incrementRatingsCountWithValue:(int) value
{
    _ratingCount = [NSNumber numberWithInt: [_ratingCount intValue] + value];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ , %@", _song, _ratingCount];
}
@end
