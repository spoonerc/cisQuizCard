//
//  QTableViewController.m
//  QuizApp2
//
//  Created by Bruce Li on 1/27/2014.
//  Copyright (c) 2014 Bruce Li. All rights reserved.
//

#import "QTableViewController.h"
#import "Question.h"

@interface QTableViewController ()

//@property NSMutableArray *staticQuestions;

@end

@implementation QTableViewController

@synthesize importedRows = _importedRows;

- (NSArray *) csvArray2QuestionsArray: (NSArray *)csvArray {
    int i = 0;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSMutableArray *ma = [[NSMutableArray alloc] init];
    
    for (NSArray *row in csvArray) {
        if (i >0) {
            Question *_question = [[Question alloc] init];
            
            _question.questionNumber = [row objectAtIndex:0];
            _question.questionContent = [row objectAtIndex:1];
            _question.answerA = [row objectAtIndex:2];
            _question.answerB = [row objectAtIndex:3];
            _question.answerC = [row objectAtIndex:4];
            _question.answerD = [row objectAtIndex:5];
            _question.correctAnswer = [row objectAtIndex:6];
            
            
            [ma addObject:_question];
            PFObject *pQuestion = [PFObject objectWithClassName:@"Question"];
            NSLog(@"Parsed Question Number %@", _question.questionNumber );
            pQuestion[@"questionNumber"] = _question.questionNumber;
            pQuestion[@"questionContent"] = _question.questionContent;
            pQuestion[@"answerA"] = _question.answerA;
            pQuestion[@"answerB"] = _question.answerB;
            pQuestion[@"answerC"] = _question.answerC;
            pQuestion[@"answerD"] = _question.answerD;
            pQuestion[@"correctAnswer"] = _question.correctAnswer;
            
            [pQuestion saveInBackground];
            
        }
        i++;
    }
    
    return (NSArray *) ma;
}

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
    
//    self.staticQuestions = [[NSMutableArray alloc] init];
//    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
//    
    
}

- (void) loadInitialData {
    
//    Question *item1 = [[Question alloc]init];
//    item1.questionContent = @"Buy Bread";
//    [self.staticQuestions addObject:item1];
    //    [self.toDoItems addObject:item1];
    //    ToDoItem *item2 = [[ToDoItem alloc]init];
    //    item2.itemName = @"Buy Milk";
    //    [self.toDoItems addObject:item2];
    //    ToDoItem *item3 = [[ToDoItem alloc]init];
    //    item3.itemName = @"Buy Eggs";
    //    [self.toDoItems addObject:item3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleOpenURL:(NSURL *) url {
    NSError *outError;
    NSString *fileString = [NSString stringWithContentsOfURL:url
                                                    encoding:NSUTF8StringEncoding error:&outError];
    if (fileString != nil) {
        self.importedRows = [self csvArray2QuestionsArray:[fileString csvRows]];
    }
    
    NSLog(@"Quiz Data has been sent to Parse!");
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.importedRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    
//    // Configure the cell...
    //Question *q = (Question *)[self.importedRows objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@. %@", q.questionNumber, q.questionContent ];
    
    return cell;
}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
//}
//
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//
//    return YES;
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */


// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}



#pragma mark - Navigation

//// In a story board-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}



@end
