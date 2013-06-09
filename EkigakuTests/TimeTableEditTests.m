//
//  TimeTableEditTests.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableEditTests.h"

#define SUNDAY 1
#define MONDAY 2
#define TUESDAY 3
#define WEDNESDAY 4
#define THURSDAY 5
#define FRIDAY 6
#define SATURDAY 7

#define HOLIDAY 1

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

- (void)testJudgmentDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger day;
    
    date = [formatter dateFromString:@"2013-06-02 00:00:00 +0900"];//Sunday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, SUNDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-03 00:00:00 +0900"];//Monday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, MONDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-04 00:00:00 +0900"];//Tuesday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, TUESDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-05 00:00:00 +0900"];//Wednesday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, WEDNESDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-06 00:00:00 +0900"];//Tursday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, THURSDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-07 00:00:00 +0900"];//Friday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, FRIDAY, @"曜日の判定が正しくありません");
    
    date = [formatter dateFromString:@"2013-06-08 00:00:00 +0900"];//Saturday
    day = [_timeTableEdit judgmentDay:date];
    STAssertEquals(day, SATURDAY, @"曜日の判定が正しくありません");
}

- (void)testJadgmentHoliday{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger day;
    
    //普通の日
    date = [formatter dateFromString:@"2013-01-02 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, 0, @"判定が正しくありません");
    
    //元日
    //1月1日
    date = [formatter dateFromString:@"2013-01-01 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //成人の日
    //1月の第2月曜日
    date = [formatter dateFromString:@"2013-01-14 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //建国記念の日
    //政令で定める日=2月11日
    date = [formatter dateFromString:@"2013-02-11 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //春分の日
    //春分日=変動
    date = [formatter dateFromString:@"2013-03-20 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //昭和の日
    //4月29日
    date = [formatter dateFromString:@"2013-04-29 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //憲法記念日
	//5月3日
    date = [formatter dateFromString:@"2013-05-03 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //みどりの日
    //5月4日
    date = [formatter dateFromString:@"2013-05-04 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //こどもの日
	//5月5日
    date = [formatter dateFromString:@"2013-05-05 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    //振替
    date = [formatter dateFromString:@"2013-05-06 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //海の日
    //7月の第3月曜日
    date = [formatter dateFromString:@"2013-07-15 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //敬老の日
	//9月の第3月曜日
    date = [formatter dateFromString:@"2013-09-16 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //秋分の日
	//秋分日=変動
    date = [formatter dateFromString:@"2013-09-23 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //体育の日
	//10月の第2月曜日
    date = [formatter dateFromString:@"2013-10-14 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //文化の日
    //11月3日
    date = [formatter dateFromString:@"2013-11-03 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //勤労感謝の日
    //11月23日
    date = [formatter dateFromString:@"2013-11-23 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
    
    //天皇誕生日
    //12月23日
    date = [formatter dateFromString:@"2013-12-23 00:00:00 +0900"];
    day = [_timeTableEdit judgmentHoliday:date];
    STAssertEquals(day, HOLIDAY, @"判定が正しくありません");
}

- (void)testHour{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger hour;
    
    date = [formatter dateFromString:@"2013-06-10 12:34:56 +0900"];
    hour = [_timeTableEdit hour:date];
    STAssertEquals(hour, 12, @"値が正しくありません");
}

- (void)testMinute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger minute;
    
    date = [formatter dateFromString:@"2013-06-10 12:34:56 +0900"];
    minute = [_timeTableEdit minute:date];
    STAssertEquals(minute, 34, @"値が正しくありません");
}

- (void)testConvertedToMinutesFromDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    NSDate *date = [NSDate alloc];
    NSInteger minute;
    
    date = [formatter dateFromString:@"2013-06-10 12:34:56 +0900"];
    minute = [_timeTableEdit convertedToMinutesFromDay:date];
    STAssertEquals(minute, 754, @"値が正しくありません");
}

- (void)testConverdedToDateFromString{
    NSDate *time;
    NSString *string = @"12:34";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date = [NSDate alloc];
    date = [formatter dateFromString:@"12:34"];
    time = [_timeTableEdit converdedToDateFromString:string];
    STAssertEqualObjects(date, time, @"値が正しくありません");
}

@end
