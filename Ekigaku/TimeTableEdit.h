//
//  TimeTableEdit.h
//  Ekigaku
//
//  Created by Nakano Asami on 2013/06/02.
//  Copyright (c) 2013年 Nakano Asami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTableEdit : NSObject{
    NSString *timeTabalePlist;
    
}
@property NSDictionary *timeTable;

- (void)loadTimeTable;
- (int)allLineNumber:(NSString *)goOrCome;
- (NSInteger)judgmentDay:(NSDate *)today;

@end
