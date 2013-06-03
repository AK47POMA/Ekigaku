//
//  TimeTableEdit.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableEdit.h"

@implementation TimeTableEdit

//timeTable_weekday.plistをtimeTableに読み込む
- (void)loadTimeTable{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"timeTable_weekday" ofType:@"plist"];
    self.timeTable = [NSDictionary dictionaryWithContentsOfFile:path];
}

//1日分の総運行数を返す
- (int)allLineNumber:(NSString *)goOrCome{
    [self loadTimeTable];
    
    NSArray *temp = [self.timeTable objectForKey:goOrCome];
    return [temp count];
}

@end
