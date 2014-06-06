//
//  AddCategoryViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 6/5/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "AddCategoryViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@interface AddCategoryViewController ()
@property (strong, nonatomic) IBOutlet UITextField *addCategory;

@end

@implementation AddCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveToParse:(id)sender {
    if (![self.addCategory.text isEqualToString:@""]) {
        PFObject *newCategory = [PFObject objectWithClassName:@"ichibanCategoryIN"];
        newCategory[@"category"] = self.addCategory.text;
        
        [newCategory saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD dismiss];
                [self.addCategory setText:@""];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else {        
        UIAlertView *notCompleteForm = [[UIAlertView alloc] initWithTitle:@"Add Category" message:@"Please fill in all the blank." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [notCompleteForm show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
