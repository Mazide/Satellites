//
//  InputStream.h
//  Satellites
//
//  Created by Nikita Demidov on 05/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* InputStreamDidMessageReceivedNotification;
NSString* InputStreamMessageKey;


@interface InputStream : NSObject

-(id)initWithFile:(NSString*)fileName frequency:(double)streamFrequency;

-(void)run;
-(void)stop;

@end
