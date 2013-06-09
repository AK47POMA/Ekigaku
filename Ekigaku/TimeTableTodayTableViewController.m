//
//  TimeTableTodayTableViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "TimeTableTodayTableViewController.h"

#define SECTIONNUMBER 1
#define NUMBER_TAG 2
#define COME_TAG 3
#define GO_TAG 4
#define BACKGROUND_TAG 5

#define CELL @"lineInfomation"

#define FONTTYPE_CELL_TIME @"GD-HighwayGothicJA-OTF"
#define FONTSIZE_CELL_TIME 24
#define FONTTYPE_CELL_NUMBER @"Impact"
#define FONTSIZE_CELL_NUMBER 20

#define WARNING_MARGIN 10 //あと10分以内に出発予定のバス
#define IMAGEFILE_NOMAL @"tile_blue.png"
#define IMAGEFILE_WARNING @"tile_red.png"
#define IMAGEFILE_NONE @"tile_gray.png"

@interface TimeTableTodayTableViewController (){
    NSInteger rowCount;
    NSDate *today;
}

@end

@implementation TimeTableTodayTableViewController

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
    
    _timeTableEdit = [[TimeTableEdit alloc] init];
    goOrComeBack = [self setgoOrComeBack];
    rowCount = 0;
    today = [NSDate date];
}

- (void)viewDidAppear:(BOOL)animated{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowCount inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];

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
    static NSString *CellIdentifier = @"lineInfomation";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *numberLabel = (UILabel*)[cell viewWithTag:NUMBER_TAG];
    UILabel *comeLabel = (UILabel*)[cell viewWithTag:COME_TAG];
    UILabel *goLabel = (UILabel*)[cell viewWithTag:GO_TAG];
    
    numberLabel.font  = [UIFont fontWithName:FONTTYPE_CELL_NUMBER size:FONTSIZE_CELL_NUMBER];
    numberLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"number"];
    comeLabel.font = [UIFont fontWithName:FONTTYPE_CELL_TIME size:FONTSIZE_CELL_TIME];
    comeLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"come"];
    goLabel.font = [UIFont fontWithName:FONTTYPE_CELL_TIME size:FONTSIZE_CELL_TIME];
    goLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"go"];
    
    //色の設定
    //表示セルの判定
    UIImageView *cellBackgroundImage = (UIImageView*)[cell viewWithTag:BACKGROUND_TAG];
    int timeNow = [_timeTableEdit convertedToMinutesFromDay:today];
    int timeCell = [_timeTableEdit convertedToMinutesFromDay:[_timeTableEdit converdedToDateFromString:comeLabel.text]];
    
    int margin = timeCell - timeNow;
    
    if (margin < 0) {
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_NONE];
    }else if (WARNING_MARGIN < margin){
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_NOMAL];
    }else{
        cellBackgroundImage.image = [UIImage imageNamed:IMAGEFILE_WARNING];
    }
    
    return cell;
}

- (NSString *)setgoOrComeBack{
    return @"error";
}

@end
