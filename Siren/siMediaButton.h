//
//  siMediaButton.h
//  Siren
//
//  Created by Tim Harris on 5/19/14.
//  Copyright (c) 2014 Tim Harris. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, siMediaButtonType){
    siPlayButton = 1,
    siPauseButton = 2,
    siNextButton = 3,
    siStopButton = 4
};

@interface siMediaButton : NSButton

@property NSString *mediaState;
@property siMediaButtonType buttonType;
@end
