//
//  TimeTableEdit.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableEdit.h"

#define WEEKDAY 0
#define SATURDAY 7
#define HOLIDAY 1

@implementation TimeTableEdit

//timeTable_weekday.plistをtimeTableに読み込む
- (void)loadTimeTable{
    NSString* path = [[NSBundle mainBundle] pathForResource:[self timeTablePlistName] ofType:@"plist"];
    self.timeTable = [NSDictionary dictionaryWithContentsOfFile:path];
}

//1日分の総運行数を返す
- (int)allLineNumber:(NSString *)goOrCome{
    [self loadTimeTable];
    return [[self.timeTable objectForKey:goOrCome] count];
}

//読み込む時刻表のファイル名をセット
- (NSString *)timeTablePlistName{
    int temp;
    temp = [self judgmentHoliday:[NSDate date]];
    if (temp == HOLIDAY) {
        timeTabalePlist = @"timeTable_holiday";//祝日
    }else{
        temp = [self judgmentDay:[NSDate date]];
        if (temp == HOLIDAY) {
            timeTabalePlist = @"timeTable_holiday";//日曜
        }else{
            if (temp == SATURDAY) {
                timeTabalePlist = @"timeTable_saturday";//土曜
            }else{
                timeTabalePlist = @"timeTable_weekday";// 平日
            }
        }
    }
    return timeTabalePlist;
}

//曜日の種類を判定
//http://ameblo.jp/yusuke-sharp9th/entry-10907692671.html
//日曜は1，土曜は7が返る
- (NSInteger)judgmentDay:(NSDate *)today{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday;
}

//祝日の判定
//http://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html
//祝日は1が返る．それ以外は0が返る．
//上手な方法を考える
- (NSInteger)judgmentHoliday:(NSDate *)today{
    NSString *day;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    day = [formatter stringFromDate:today];
    
    if ([day isEqual: @"2013-01-01"] || [day isEqual: @"2013-01-14"] || [day isEqual: @"2013-02-11"] || [day isEqual: @"2013-03-20"] || [day isEqual: @"2013-04-29"] || [day isEqual: @"2013-05-03"] || [day isEqual: @"2013-05-04"] || [day isEqual: @"2013-05-05"] || [day isEqual: @"2013-07-15"] || [day isEqual: @"2013-09-16"] || [day isEqual: @"2013-09-23"] || [day isEqual: @"2013-10-14"] || [day isEqual: @"2013-11-03"] || [day isEqual: @"2013-11-23"] || [day isEqual: @"2013-12-23"] || [day isEqual: @"2013-05-06"] || [day isEqual: @"2013-11-04"]) {
        return HOLIDAY;
    }
    return 0;
}

//NSDate型を時間(HH)の要素だけにし，NSIntegerで返す
- (NSInteger)hour:(NSDate *)today{
    NSString *temp;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    temp = [formatter stringFromDate:today];
    return [temp intValue];
}

//NSDate型を分(mm)の要素だけにし，NSIntegerで返す
- (NSInteger)minute:(NSDate *)today{
    NSString *temp;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    temp = [formatter stringFromDate:today];
    return [temp intValue];
}

//NSDate型の時分を分に変換する
- (NSInteger)convertedToMinutesFromDay:(NSDate *)day{
    return [self hour:day] * 60 + [self minute:day];
}

//@"HH:mm"なNSString型をNSDate型に変換する
- (NSDate *)converdedToDateFromString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate* formatterDate = [formatter dateFromString:string];
    return formatterDate;
}

@end
