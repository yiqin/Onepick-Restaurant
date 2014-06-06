//
//  AddDishViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 6/1/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "AddDishViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "NSDictionary+DictionaryToJSONString.h"

@interface AddDishViewController ()
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *nameChinese;
@property (strong, nonatomic) IBOutlet UITextField *price;

@end

@implementation AddDishViewController

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
    [self.category becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveToParse:(id)sender {
    if (![self.category.text isEqualToString:@""] && ![self.nameChinese.text isEqualToString:@""] && ![self.name.text isEqualToString:@""] && ![self.price.text isEqualToString:@""]) {
        
        [SVProgressHUD show];

        // selection (To-Do)
        PFObject *newDish = [PFObject objectWithClassName:@"DishesIN"];
        newDish[@"category"] = self.category.text;
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumberPrice = [f numberFromString:self.price.text];
        NSArray *dishArrayKeys = [NSArray arrayWithObjects:@"nameChinese", @"name", @"price", nil];
        NSArray *dishArrayObjects = [NSArray arrayWithObjects:self.nameChinese.text, self.name.text, myNumberPrice, nil];
        
        NSDictionary *dishDictionaryInput = [NSDictionary dictionaryWithObjects:dishArrayObjects forKeys:dishArrayKeys];
        NSString *dishDictionaryInputString = [dishDictionaryInput DictionaryToJSONString];
        
        newDish[@"dish"] = dishDictionaryInputString;
        newDish[@"orderCount"] = @0;
        
        [newDish saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD dismiss];
                [self.category setText:@""];
                [self.name setText:@""];
                [self.nameChinese setText:@""];
                [self.price setText:@""];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else {
        UIAlertView *notCompleteForm = [[UIAlertView alloc] initWithTitle:@"Add Dish" message:@"Please fill in all the blank." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
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
