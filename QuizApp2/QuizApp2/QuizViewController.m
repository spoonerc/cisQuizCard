//
//  QuizViewController.m
//  QuizApp2
//
//  Created by Bruce Li on 1/28/2014.
//  Copyright (c) 2014 Bruce Li. All rights reserved.
//

#import "QuizViewController.h"
#import "QTableViewController.h"
#import "QuestionViewController.h"
#import <Parse/Parse.h>
#import "Question.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

NSArray *listQuestionNumbers;
NSArray *listQuestionContent;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *collectViewLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectViewLayout.sectionInset = (UIEdgeInsetsMake(90, 100, 0, 100));
    
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    //PFQuery *query = [Question query];
    
    
    
    
    
    [query selectKeys: @[@"questionNumber", @"questionContent", @"answerA", @"answerB", @"answerC", @"answerD", @"correctAnswer"]];
    [query orderByAscending:@"questionNumber"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *questions, NSError *error) {
        if (!error) {
            //questions = [questions objectForKey:@"Question"];
            NSLog(@"Successfully retrieved %lu Questions.", (unsigned long)questions.count);

            
            //listQuestions =
            for (PFObject *question in questions) {

//                int qNumber = [question[@"questionNumber"]intValue];
//                NSString *qContent = question[@"questionContent"];
//                NSString *answerA = question[@"answerA"];
//                NSString *answerB = question[@"answerB"];
//                NSString *answerC = question[@"answerC"];
//                NSString *answerD = question[@"answerD"];
//                NSString *correctAnswer = question[@"correctAnswer"];
                
                Question *_question = [[Question alloc] init];
                
                _question.questionNumber = question[@"questionNumber"];
                _question.questionContent = question[@"questionContent"];
                _question.answerA = question[@"answerA"];
                _question.answerB = question[@"answerB"];
                _question.answerC = question[@"answerC"];
                _question.answerD = question[@"answerD"];
                _question.correctAnswer = question[@"correctAnswer"];
                
                NSLog(@"Successfully retrieved Question %@.", question[@"questionNumber"]);
            }
        }else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
	// Do any additional setup after loading the view.
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *squareImage = (UIImageView *)[cell viewWithTag:100];
    UILabel *questionLabel = (UILabel *)[cell viewWithTag:10];
    
    questionLabel.text= [NSString stringWithFormat:@"%ld", (long)indexPath.row+1];
    
    squareImage.image = [UIImage imageNamed:@"5.png"];
                         
    return cell;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //this function is used to pass data using the navigation segue
    if ([segue.identifier isEqual:@"goToQuestion"]) {
        
        //questionsViewed++;  //add one to the number of questions viewed
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        QuestionViewController *destViewC = segue.destinationViewController;
        
        //indexPath2 = [indexPaths objectAtIndex:0];
        
        //this is where the action happens; send info to the question view
        //destViewC.attempts = [attemptsArray objectAtIndex:indexPath2.row];  //to decide if question should be available
        //destViewC.correct = [theList objectAtIndex:indexPath2.row];         //to determine correct ans
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(questionViewed:) name:@"attempted" object:nil];
        //NSLog(@"%@", [theList objectAtIndex:indexPath2.row]);
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
