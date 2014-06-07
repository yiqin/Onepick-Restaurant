//
//  EditViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 6/6/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "EditViewController.h"
#import <dispatch/dispatch.h>
#import <Parse/Parse.h>
#import "NSString+JSONStringToDictionary.h"
#import "NSDictionary+DictionaryToJSONString.h"
#import "SVProgressHUD.h"

@interface EditViewController ()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *nameChinese;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation EditViewController
@synthesize objectId;


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
    
    [SVProgressHUD show];
    
    PFQuery *query = [PFQuery queryWithClassName:@"DishesIN"];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
            NSDictionary *dishInformation =  [[object objectForKey:@"dish"] JSONStringToDictionay];
            self.name.text = [dishInformation objectForKey:@"name"];
            self.nameChinese.text = [dishInformation objectForKey:@"nameChinese"];
            NSNumber *price = [dishInformation objectForKey:@"price"];
            [self.priceTextField setPlaceholder:[NSString stringWithFormat:@"%.2f",[price floatValue]]];
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteDish:(id)sender {
    UIAlertView *deleteDish = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [deleteDish show];
}

- (IBAction)updatePrice:(id)sender {
    if (![self.priceTextField.text isEqualToString:@""]) {
        [SVProgressHUD show];
        PFQuery *query = [PFQuery queryWithClassName:@"DishesIN"];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumberPrice = [f numberFromString:self.priceTextField.text];
        NSArray *dishArrayKeys = [NSArray arrayWithObjects:@"nameChinese", @"name", @"price", nil];
        NSArray *dishArrayObjects = [NSArray arrayWithObjects:self.nameChinese.text, self.name.text, myNumberPrice, nil];
        NSDictionary *dishDictionaryInput = [NSDictionary dictionaryWithObjects:dishArrayObjects forKeys:dishArrayKeys];
        NSString *dishDictionaryInputString = [dishDictionaryInput DictionaryToJSONString];

        [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
            object[@"dish"] = dishDictionaryInputString;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [SVProgressHUD dismiss];
                }
            }];
        }];
        
    }
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //NSLog(@"Cancel button clicked");
            break;
        case 1:
            //NSLog(@"OK button clicked");
            [SVProgressHUD show];
            [self removeDishOnParse];
            
            break;
        default:
            break;
    }
}

- (void)removeDishOnParse {
    PFQuery *query = [PFQuery queryWithClassName:@"DishesIN"];
    
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
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
