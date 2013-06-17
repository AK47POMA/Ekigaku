//
//  TimeTableTodayTableViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableTodayTableViewController.h"
#import "TimeTableTodayViewController.h"

#import "SVProgressHUD.h"

#define SECTIONNUMBER 1
#define NUMBER_TAG 2
#define COME_TAG 3
#define GO_TAG 4
#define BACKGROUND_TAG 5

#define CELL @"lineInformation"

#define FONTTYPE_CELL_TIME @"GD-HighwayGothicJA-OTF"
#define FONTSIZE_CELL_TIME 24
#define FONTTYPE_CELL_NUMBER @"Impact"
#define FONTSIZE_CELL_NUMBER 20

#define WARNING_MARGIN 10 //あと10分以内に出発予定のバス
#define IMAGEFILE_NOMAL @"tile_blue.png"
#define IMAGEFILE_WARNING @"tile_red.png"
#define IMAGEFILE_NONE @"tile_gray.png"

@interface TimeTableTodayTableViewController (){
}

@end

@implementation TimeTableTodayTableViewController
@synthesize date;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [SVProgressHUD show]; // ぐるぐる
    _timeTableEdit = [[TimeTableEdit alloc] init];
    goOrComeBack = [self setgoOrComeBack];
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [self auotScrolling];
    [SVProgressHUD dismiss]; // ぐるぐる消す
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTIONNUMBER;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_timeTableEdit allLineNumber:goOrComeBack];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    date = [NSDate date];
    static NSString *CellIdentifier = @"lineInformation";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *numberLabel = (UILabel*)[cell viewWithTag:NUMBER_TAG];
    UILabel *comeLabel = (UILabel*)[cell viewWithTag:COME_TAG];
    UILabel *goLabel = (UILabel*)[cell viewWithTag:GO_TAG];
    
    numberLabel.font  = [UIFont fontWithName:FONTTYPE_CELL_NUMBER size:FONTSIZE_CELL_NUMBER];
    numberLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"number"];
    numberLabel.textColor = [UIColor whiteColor];
    comeLabel.font = [UIFont fontWithName:FONTTYPE_CELL_TIME size:FONTSIZE_CELL_TIME];
    comeLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"come"];
    comeLabel.textColor = [UIColor whiteColor];
    goLabel.font = [UIFont fontWithName:FONTTYPE_CELL_TIME size:FONTSIZE_CELL_TIME];
    goLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"go"];
    goLabel.textColor = [UIColor whiteColor];
    
    //色の設定
    UIImageView *cellBackgroundImage = (UIImageView*)[cell viewWithTag:BACKGROUND_TAG];
    int timeNow = [_timeTableEdit convertedToMinutesFromDay:date];
    int timeCell = [_timeTableEdit convertedToMinutesFromDay:[_timeTableEdit converdedToDateFromString:comeLabel.text]];
    int margin = timeCell - timeNow;
    
    if (margin < 0) {//差が負のとき
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_NONE];
    }else if (WARNING_MARGIN < margin){
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_NOMAL];
    }else{
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_WARNING];
    }
    
    return cell;
}

- (NSInteger)setRowCount{
    int temp;
    int rowCount = 0;
    
    int timeNow = [_timeTableEdit convertedToMinutesFromDay:date];
    int timeCell;
    int margin;
    
    for (temp = 0; temp < [_timeTableEdit allLineNumber:goOrComeBack]; temp++) {
        timeCell = [_timeTableEdit convertedToMinutesFromDay:[_timeTableEdit converdedToDateFromString:[[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:temp] objectForKey:@"come"]]];
        margin = timeCell - timeNow;
        if (margin < 0) {//差が負のとき
            rowCount++;
        }else{
            break;
        }
    }
    if (temp == rowCount) {//最後のセルの読み込みエラーを防ぐ
        rowCount = rowCount -1;
    }
    return rowCount;
}

- (void)auotScrolling{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self setRowCount] inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (NSString *)setgoOrComeBack{
    return @"error";
}

@end
