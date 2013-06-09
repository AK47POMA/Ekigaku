//
//  TimeTableTodayViewController.h
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableTodayViewController : UIViewController{
    
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *hourLabel;
    __weak IBOutlet UILabel *minuteLabel;
    __weak IBOutlet UILabel *whatdayLabel;
}
- (IBAction)pushUpdateButton:(id)sender;

@end
