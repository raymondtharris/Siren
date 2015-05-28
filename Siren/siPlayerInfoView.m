//
//  siPlayerInfoView.m
//  Siren
//
//  Created by Tim Harris on 5/14/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siPlayerInfoView.h"

@implementation siPlayerInfoView

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
    
    [[NSColor colorWithCalibratedRed:135.0/255.0 green:206.0/255.0 blue:255.0/255.0 alpha:1.0] setFill];
    NSBezierPath *outerPath = [NSBezierPath bezierPath];
    [outerPath appendBezierPathWithRect:NSMakeRect(2.0, 2.0, 596.0, 94.0)];
    [outerPath fill];
    [outerPath stroke];
    
    [super drawRect:dirtyRect];

    // Drawing code here.
   
}

@end
