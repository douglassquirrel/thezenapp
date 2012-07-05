//
//  LogViewController.m
//  zen
//
//  Created by Douglas Squirrel on 05/07/2012.
//  Copyright (c) 2012 TheZenApp, Ltd. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController 

@synthesize delegate;
@synthesize records;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [table reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [records count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableIdentifier"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SimpleTableIdentifier"] autorelease];
    }
    
    cell.textLabel.text = [records recordAt:indexPath.row];
    
    return cell;
}

- (IBAction) back:(id) sender       { [delegate closeLog];  }

@end
