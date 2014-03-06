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
    double frequency;
}

-(id)initWithFile:(NSString*)fileName frequency:(double)streamFrequency{
    self = [super init];
    if (self) {
        NSString *filePath = [[[NSBundle mainBundle] resourcePath]
                              stringByAppendingPathComponent:fileName];
        fileReader = [[FileReader alloc] initWithFilePath:filePath];
        frequency =  streamFrequency;
    }
    return self;
}


-(void)run{
    timer = [NSTimer scheduledTimerWithTimeInterval:frequency target:self selector:@selector(getMessage) userInfo:nil repeats:YES];
}

-(void)stop{
    [timer invalidate];
}

-(void)getMessage{
    NSString* message = [fileReader readLine];
    if (message) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:@"message"];
        [[NSNotificationCenter defaultCenter] postNotificationName:InputStreamDidMessageReceivedNotification object:self userInfo:userInfo];
    }
}

@end
