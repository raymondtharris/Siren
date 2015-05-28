//
//  siAppView.m
//  Siren
//
//  Created by Tim Harris on 5/26/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siAppView.h"

@implementation siAppView

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
    
    
    // Drawing code here.
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
