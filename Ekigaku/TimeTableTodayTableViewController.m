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

@interface TimeTableTodayTableViewController ()

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
    
    numberLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"number"];
    comeLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"come"];
    goLabel.text = [[[_timeTableEdit.timeTable objectForKey:goOrComeBack] objectAtIndex:indexPath.row] objectForKey:@"go"];
    return cell;
}

- (NSString *)setgoOrComeBack{
    return @"error";
}

@end
