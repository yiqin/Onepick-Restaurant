//
//  EditViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 6/6/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

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

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //NSLog(@"Cancel button clicked");
            break;
        case 1:
            //NSLog(@"OK button clicked");
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
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
