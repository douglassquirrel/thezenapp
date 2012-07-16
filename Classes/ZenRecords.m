//
//  ZenRecords.m
//  zen
//
//  Created by Douglas Squirrel on 05/07/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "ZenRecords.h"

@interface ZenRecords()
-(void) createFileName;
-(void) readRecords;
@end

@implementation ZenRecords

- (id)init {
    if (!(self = [super init])) { return nil; }
    
    [self createFileName];
    [self readRecords];
    
    return self;
}

- (void) createFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    fileName = [[documentsDirectory stringByAppendingPathComponent:@"zenlog.dat"] retain];
}

- (void) readRecords
{
    records = [[NSMutableArray alloc] initWithContentsOfFile: fileName];
    if (records == nil) { records = [[NSMutableArray alloc] init]; }
}

-(void) timerUpdated:(NSString *) zenTimeString { 
    NSString *now = [NSDateFormatter localizedStringFromDate:[NSDate date] 
                                                   dateStyle:NSDateFormatterLongStyle 
                                                   timeStyle:NSDateFormatterShortStyle];
    NSString *record = [[NSString stringWithFormat:@"%@ -- %@", now, zenTimeString] retain];
    [records insertObject:record atIndex:0];
    if ([records count] >= 7) { [records removeObjectsInRange:NSMakeRange(6, records.count - 6)]; }

    [records writeToFile:fileName atomically:YES];
}

-(int) count                { return [records count]; }
-(id)  recordAt:(int) index { return [records objectAtIndex:index]; }

-(void) dealloc {
    [fileName release];
    [records release];
    [super dealloc];
}

@end
