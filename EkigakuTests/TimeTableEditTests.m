//
//  TimeTableEditTests.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableEditTests.h"

#define TIMETABLE_WEEKDAY_GO_SUM 48
#define TIMETABLE_WEEKDAY_COMEBACK_SUM 46

@implementation TimeTableEditTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    _timeTableEdit = [[TimeTableEdit alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testloadTimeTable
{
    [_timeTableEdit loadTimeTable];
    STAssertNotNil(_timeTableEdit.timeTable, @"ファイルが読み込めていません");
}

- (void)testAllLineNumber{
    STAssertEquals(TIMETABLE_WEEKDAY_GO_SUM, [_timeTableEdit allLineNumber:@"go"], @"1日の総運行数が違います．");
    STAssertEquals(TIMETABLE_WEEKDAY_COMEBACK_SUM, [_timeTableEdit allLineNumber:@"comeBack"], @"1日の総運行数が違います．");
}

@end
