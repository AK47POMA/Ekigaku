//
//  InformationViewController.m
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/14.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import "InformationViewController.h"

@implementation InformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *temp = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];;
    temp = [@"ver " stringByAppendingString:temp];
    versionLabel.text = temp;
}

@end
