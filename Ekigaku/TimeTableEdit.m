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
    int temp = [self judgmentDay:[NSDate date]];
    if (temp == HOLIDAY) {
        timeTabalePlist = @"timeTable_holiday";//日曜，祝日
    }else{
        if (temp == SATURDAY) {
            timeTabalePlist = @"timeTable_saturday";//土曜
        }else{
            timeTabalePlist = @"timeTable_weekday";// 平日
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

@end
