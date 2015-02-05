//
//  NMEAMessageParser.m
//  Satellites
//
//  Created by Nikita Demidov on 07/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#import "NMEAMessageParser.h"
#import "NMEAMessage.h"

@implementation NMEAMessageParser


-(NMEAMessage*)generateNMEAMessageFromString:(NSString*)string{
    NSArray* fields = [self splitMessage:string];
    NMEAMessage* message = [[NMEAMessage alloc] initWithFields:fields validCheckSum:[self checkMessageOnError:string]];
    return message;
}

-(BOOL)checkMessageOnError:(NSString*)message{
    message = [message substringFromIndex:1]; // удаляем знак доллара "$" (контрольная сумма считается по строке, которая находится между знаком доллара ($) и звездочкой (*))
    NSArray* tailOfMessage = [message componentsSeparatedByString:@"*"];
    if (tailOfMessage.count != 2) {
        return NO;
    }
    NSString* checkSumStr = [tailOfMessage objectAtIndex:1];
    message = [[message componentsSeparatedByString:@"*"] objectAtIndex:0];
    unsigned checkSum = 0;
    NSScanner *scanner = [NSScanner scannerWithString:checkSumStr];
    [scanner scanHexInt:&checkSum];
    
    int result = 0;
    for ( int i = 0; i  < message.length; i++ )
    {
        char a = [message characterAtIndex:i];
        result ^= a;
    }
    if (result == checkSum) {
        return YES;
    } else {
        return NO;
    }
    
    // выполняем XOR для сообщения и сраниваем с контрольной суммой
    
}

-(NSArray*)splitMessage:(NSString*)message{
    NSMutableArray* propertes;
    NSArray* tailOfMessage;
    message = [message substringFromIndex:1]; // удаляем знак доллара ""
    propertes = [NSMutableArray arrayWithArray:[message componentsSeparatedByString:@","]];
    //после разбития строки на подстроки, разделяемые "," получаем массив свойств
    //в последнем элементе массива находится SNR последнего в списке свойств спутника и контрольная сумма,
    //разделенные звездочкой "*"
    tailOfMessage = [[propertes objectAtIndex:propertes.count - 1] componentsSeparatedByString:@"*"];
    [propertes replaceObjectAtIndex:propertes.count-1 withObject:[tailOfMessage objectAtIndex:0]];
    
    return propertes;
}

@end
