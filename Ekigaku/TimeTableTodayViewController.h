//
//  TimeTableTodayViewController.h
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableTodayViewController : UIViewController{
    
    __weak IBOutlet UILabel *monthLabel;
    __weak IBOutlet UILabel *dayLabel;
    __weak IBOutlet UILabel *whatdayLabel;
    __weak IBOutlet UILabel *timeLabel;
}
- (IBAction)pushUpdateButton:(id)sender;

- (IBAction)pushInformationButton:(id)sender;

@end
