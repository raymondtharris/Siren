//
//  siButton.m
//  Siren
//
//  Created by Tim Harris on 5/12/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siButton.h"

@implementation siButton

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
    //[super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath *outerPath = [NSBezierPath bezierPath];
    NSRect buttonRect = NSMakeRect(6.0, 5.0, 70.0, 21.0);
    [outerPath appendBezierPathWithRoundedRect:buttonRect xRadius:3.0 yRadius:3.0];
    [outerPath setLineWidth:2.0];
    [[NSColor colorWithCalibratedRed:135.0/255.0 green:206.0/255.0 blue:255.0/255.0 alpha:1.0] setStroke];
    [outerPath stroke];

    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *attr = @{NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: [NSColor colorWithCalibratedRed:135.0/255.0 green:206.0/255.0 blue:255.0/255.0 alpha:1.0]};
    [self.title drawInRect: NSMakeRect(6.0, 8.0, 70.0, 21.0) withAttributes:attr];
    
}

@end
