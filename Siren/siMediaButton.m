//
//  siMediaButton.m
//  Siren
//
//  Created by Tim Harris on 5/19/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import "siMediaButton.h"

@implementation siMediaButton

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
    //NSLog(@"%@", _mediaState);
    NSBezierPath *outerPath = [NSBezierPath bezierPath];
    NSRect buttonRect = NSMakeRect(2.0, 2.0, dirtyRect.size.width-6, dirtyRect.size.height-6);
    [outerPath appendBezierPathWithRoundedRect:buttonRect xRadius:buttonRect.size.height/2 yRadius:buttonRect.size.width/2];
    [outerPath setLineWidth:2.0];
    
    [outerPath stroke];
    
    //NSLog(@"%@", self.title);
    if ([_mediaState isEqualToString:@"pause"]|| [self.title isEqualToString: @"Pause"]){
        NSBezierPath * mediaButton = [NSBezierPath bezierPath];
        [mediaButton moveToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*8/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*8/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height*2/3)];
        [mediaButton closePath];
        
        [mediaButton moveToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*13/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*13/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height*2/3)];
        [mediaButton closePath];
        
        
        [mediaButton stroke];
        [mediaButton fill];
        
    }
    else if ([_mediaState isEqualTo:@"next"] || [self.title isEqualToString: @"Next"]){
        NSBezierPath * mediaButton = [NSBezierPath bezierPath];
        [mediaButton moveToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*8/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*8/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*6/18, buttonRect.size.height*2/3)];
        [mediaButton closePath];
        
        [mediaButton moveToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*16/18, buttonRect.size.height/2)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*11/18, buttonRect.size.height*2/3)];
        [mediaButton closePath];
        
        [mediaButton stroke];
        [mediaButton fill];
    }
    else if ([_mediaState isEqualTo:@"play"] || [self.title isEqualToString: @"Play"]){
        NSBezierPath * mediaButton = [NSBezierPath bezierPath];
        [mediaButton moveToPoint:NSMakePoint(buttonRect.size.width*4/9, buttonRect.size.height*2/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*6/9, buttonRect.size.height/2)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*4/9, buttonRect.size.height/3)];
        [mediaButton lineToPoint:NSMakePoint(buttonRect.size.width*4/9, buttonRect.size.height*2/3)];
        [mediaButton closePath];
        [mediaButton stroke];
        [mediaButton fill];
    }
    
    
    
}

@end
