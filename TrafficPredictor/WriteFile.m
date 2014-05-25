//
//  WriteFile.m
//  TrafficPredictor
//
//  Created by tqthanh on 5/25/14.
//  Copyright (c) 2014 JVN. All rights reserved.
//

#import "WriteFile.h"

@implementation WriteFile

+(void) writeGPS: (NSURL*)url withLatitude:(NSString*) Latitude
   withLongitude:(NSString*) Longitude atTime:(NSString*) Time
         address:(NSString*) MAC
{
    NSString* content = [NSString stringWithContentsOfURL: url encoding:NSUTF8StringEncoding error:nil];
    NSString* GPSdata = [NSString stringWithFormat:@"%@ %@ %@ %@",Latitude,Longitude,Time,MAC];
    
    NSString* newContent = [NSString stringWithFormat:@"%@\n%@",content,GPSdata];
    
    [newContent writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

@end
