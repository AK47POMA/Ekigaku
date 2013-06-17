//
//  timeTableTodayViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableTodayViewController.h"
#import "TimeTableEdit.h"
#import "TimeTableTodayTableViewController.h"

#import "SVProgressHUD.h"

#define TIMETABLE_SEGUE @"timeTable"

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

@interface TimeTableTodayViewController (){
    NSDate *date;
}

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
    [SVProgressHUD show];
    [self update];
    [[[self.childViewControllers objectAtIndex:0] tableView] reloadData];
    [[self.childViewControllers objectAtIndex:0] auotScrolling];
    
    [SVProgressHUD dismiss]; // 消す
}

- (IBAction)pushInformationButton:(id)sender {
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    
    UIImage *informationBackgroundImage = [UIImage imageNamed:@"black_50.png"];  // ボタンにする画像を生成する
    UIButton *informationBackgroundButton = [[UIButton alloc]
                      initWithFrame:CGRectMake(0, 0, mainScreen.size.width, mainScreen.size.height)];  // ボタンのサイズを指定する
    [informationBackgroundButton setBackgroundImage:informationBackgroundImage forState:UIControlStateNormal];  // 画像をセットする
    // ボタンが押された時にhogeメソッドを呼び出す
    [informationBackgroundButton addTarget:self
            action:@selector(pushInformationBackgroundButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:informationBackgroundButton];
    
    UIViewController *informationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"informationView"];
    informationViewController.view.frame = CGRectMake(15, mainScreen.size.height - 230 - 65, 295, 230);
    [self.view addSubview:informationViewController.view];
}

-(void)pushInformationBackgroundButton:(UIButton*)button{
    int temp = [self.view.subviews count];
    [[self.view.subviews objectAtIndex:temp - 1] removeFromSuperview];
    [[self.view.subviews objectAtIndex:temp - 2] removeFromSuperview];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:TIMETABLE_SEGUE] ) {
        TimeTableTodayTableViewController *timeTableTodayTableViewController = [segue destinationViewController];
        timeTableTodayTableViewController.date = date;
    }
}

- (void)update{
    date = [NSDate date];
    
    //monthLabelの更新
    NSDateFormatter *month = [[NSDateFormatter alloc] init];
    month.dateFormat = @"MM";
    monthLabel.text = [month stringFromDate:date];
    monthLabel.font = [UIFont fontWithName:FONTTYPE_HEADER size:FONTSIZE_MONTH];
    monthLabel.textColor = [UIColor whiteColor];
    
    //dayLabelの更新
    NSDateFormatter *day = [[NSDateFormatter alloc] init];
    day.dateFormat = @"dd";
    dayLabel.text = [day stringFromDate:date];
    dayLabel.font = [UIFont fontWithName:FONTTYPE_DAY size:FONTSIZE_DAY];
    dayLabel.textColor = [UIColor whiteColor];
    
    //timeLabelの更新
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    time.dateFormat = @"HH:mm";
    timeLabel.text = [time stringFromDate:date];
    timeLabel.font = [UIFont fontWithName:FONTTYPE_TIME size:FONTSIZE_TIME];
    timeLabel.textColor = [UIColor whiteColor];
    
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
    whatdayLabel.textColor = [UIColor whiteColor];
}
@end
