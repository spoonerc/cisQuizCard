//
//  QTableViewController.h
//  QuizApp2
//
//  Created by Bruce Li on 1/27/2014.
//  Copyright (c) 2014 Bruce Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ParsingExtensions.h"
#import <Parse/Parse.h>


@interface QTableViewController : UITableViewController

- (void) handleOpenURL: (NSURL *) url;

@property (strong, nonatomic) NSArray *importedRows;

@end
