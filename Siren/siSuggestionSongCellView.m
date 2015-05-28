//
//  siSuggestionSongCellView.m
//  Siren
//
//  Created by Tim Harris on 5/11/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siSuggestionSongCellView.h"

@implementation siSuggestionSongCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath *path = [NSBezierPath bezierPath];
    NSRect rect = NSMakeRect(185.0, 5.0, 30.0, 30.0);
    [path appendBezierPathWithRoundedRect:rect xRadius:15.0 yRadius:15.0];
    [path setLineWidth:2.0];
    [_strokeColor setStroke];
    [path stroke];
}

@end
