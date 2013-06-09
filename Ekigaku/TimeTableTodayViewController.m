//
//  timeTableTodayViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableTodayViewController.h"
#import "TimeTableEdit.h"

#define FONTTYPE_HEADER @"Impact"
#define FONTSIZE_MONTH 48
#define FONTSIZE_WHATDAY 40
#define FONTTYPE_DAY @"Haettenschweiler"
#define FONTSIZE_DAY 112
#define FONTTYPE_TIME @"GD-HighwayGothicJA-OTF"
#define FONTSIZE_TIME 24

#define SUNDAY 1
#define MONDAY 2
#define TUESDAY 3
#define WEDNESDAY 4
#define THURSDAY 5
#define FRIDAY 6
#define SATURDAY 7

@interface TimeTableTodayViewController ()

@end

@implementation TimeTableTodayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushUpdateButton:(id)sender {
    [self update];
}

- (void)update{
    NSDate *date = [NSDate date];
    
    //monthLabelの更新
    NSDateFormatter *month = [[NSDateFormatter alloc] init];
    month.dateFormat = @"MM";
    monthLabel.text = [month stringFromDate:date];
    monthLabel.font = [UIFont fontWithName:FONTTYPE_HEADER size:FONTSIZE_MONTH];
    
    //dayLabelの更新
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    day.dateFormat = @"dd";
    dayLabel.text = [day stringFromDate:date];
    dayLabel.font = [UIFont fontWithName:FONTTYPE_DAY size:FONTSIZE_DAY];
    
    //timeLabelの更新
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    time.dateFormat = @"HH:mm";
    timeLabel.text = [time stringFromDate:date];
    timeLabel.font = [UIFont fontWithName:FONTTYPE_TIME size:FONTSIZE_TIME];
    
    //timeLabelの更新
    TimeTableEdit *_timeTableEdit;
    _timeTableEdit = [[TimeTableEdit alloc] init];
    NSString *temp;
    switch ([_timeTableEdit judgmentDay:date]) {
        case SUNDAY:
            temp = @"SUN";
            break;
        case MONDAY:
            temp = @"MON";
            break;
        case TUESDAY:
            temp = @"TUE";
            break;
        case WEDNESDAY:
            temp = @"WED";
            break;
        case THURSDAY:
            temp = @"THU";
            break;
        case FRIDAY:
            temp = @"FRI";
            break;
        case SATURDAY:
            temp = @"SAT";
            break;
        default:
            temp = @"";
            break;
    }
    whatdayLabel.text = temp;
    whatdayLabel.font = [UIFont fontWithName:FONTTYPE_HEADER size:FONTSIZE_WHATDAY];
}
@end
