//
//  timeTableTodayViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableTodayViewController.h"
#import "TimeTableEdit.h"

#import "SVProgressHUD.h"

#define FONTTYPE_HEADER @"Impact"
#define FONTSIZE_WHATDAY 38
#define FONTSIZE_HOUR 48
#define FONTTYPE_MINUTE @"Haettenschweiler"
#define FONTSIZE_MINUTE 110
#define FONTTYPE_DATE @"GD-HighwayGothicJA-OTF"
#define FONTSIZE_DATE 24

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

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushUpdateButton:(id)sender {
    [SVProgressHUD show]; // ぐるぐる
    [self update];
    [SVProgressHUD dismiss]; // 消す
}

- (void)update{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //dateLabelの更新
    formatter.dateFormat = @"MM/dd";
    dateLabel.text = [formatter stringFromDate:date];
    dateLabel.font = [UIFont fontWithName:FONTTYPE_DATE size:FONTSIZE_DATE];
    
    //hourLabelの更新
    formatter.dateFormat = @"HH:";
    hourLabel.text = [formatter stringFromDate:date];
    hourLabel.font = [UIFont fontWithName:FONTTYPE_HEADER size:FONTSIZE_HOUR];
    
    //minuteLabelの更新
    formatter.dateFormat = @"mm";
    minuteLabel.text = [formatter stringFromDate:date];
    minuteLabel.font = [UIFont fontWithName:FONTTYPE_MINUTE size:FONTSIZE_MINUTE];
    
    //whatdayLabelの更新
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
