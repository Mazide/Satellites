//
//  InputStream.m
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "InputStream.h"
#import "FileReader.h"

NSString* InputStreamDidMessageReceivedNotification = @"messageReceived";
NSString* InputStreamMessageKey = @"message";

@implementation InputStream{
    FileReader* fileReader;
    NSTimer* timer;
    LinesPerSec linesPerSec;
    BOOL isTimerWork;
    float timeInterval;
}

-(id)initWithFile:(NSString*)fileName linesPerSecond:(LinesPerSec)linesPerSecond{
    self = [super init];
    if (self) {
        NSString *filePath = [[[NSBundle mainBundle] resourcePath]
                              stringByAppendingPathComponent:fileName];
        fileReader = [[FileReader alloc] initWithFilePath:filePath];
        isTimerWork = NO;
        timeInterval = 1.0f / linesPerSecond;
    }
    return self;
}


-(void)run{
    if (!isTimerWork) {
        timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(getMessage) userInfo:nil repeats:YES];
        isTimerWork = YES;
    }
}

-(void)stop{
    [timer invalidate];
    isTimerWork = NO;
}

-(void)changeReadSpeed:(LinesPerSec)linesperSec{
    timeInterval = 1.0f/linesperSec;
    if (isTimerWork) {
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(getMessage) userInfo:nil repeats:YES];
    }
}

-(void)getMessage{
    NSString* message = [fileReader readLine];
    if (message) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:InputStreamDidMessageReceivedNotification object:self userInfo:userInfo];
    }
}

@end
