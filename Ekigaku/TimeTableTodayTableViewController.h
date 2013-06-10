//
//  TimeTableTodayTableViewController.h
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimeTableEdit.h"

@interface TimeTableTodayTableViewController : UITableViewController{
    TimeTableEdit *_timeTableEdit;
    NSString *goOrComeBack;
}

- (void)auotScrolling;

@property NSDate *date;

@end
