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

- (void)testJudgmentDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger day;
    
    date = [formatter dateFromString:@"2013-06-02 00:00:00 +0900"];//Sunday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 1, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-03 00:00:00 +0900"];//Monday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 2, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-04 00:00:00 +0900"];//Tuesday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 3, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-05 00:00:00 +0900"];//Wednesday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 4, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-06 00:00:00 +0900"];//Tursday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 5, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-07 00:00:00 +0900"];//Friday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 6, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-08 00:00:00 +0900"];//Saturday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, 7, @"曜日の判定が正しくありません");
}

@end
