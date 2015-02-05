//
//  InputStream.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  Specifies count of line per second
 */
typedef int LinesPerSec;

NSString* InputStreamDidMessageReceivedNotification;
NSString* InputStreamMessageKey;

@interface InputStream : NSObject

-(id)initWithFile:(NSString*)fileName linesPerSecond:(LinesPerSec)linesPerSecond;

-(void)run;
-(void)stop;
-(void)changeReadSpeed:(LinesPerSec)linesperSec;

@end
