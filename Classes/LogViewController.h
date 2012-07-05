//
//  LogViewController.h
//  zen
//
//  Created by Douglas Squirrel on 05/07/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenRecords.h"

@protocol LogDelegate <NSObject>

-(void)closeLog;

@end

@interface LogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *table;
    IBOutlet UIButton *backButton;
    id <LogDelegate> delegate;
    ZenRecords *records;
}

- (IBAction) back:(id) sender;

@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)id records;
@end
