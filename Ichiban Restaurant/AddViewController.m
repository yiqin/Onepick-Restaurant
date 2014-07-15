//
//  AddViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 7/14/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "AddViewController.h"
#import "LoginViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

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
    [self checkLogin];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkLogin
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSignedUp"]) {
        LoginViewController *loginViewController = (LoginViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [loginViewController.navigationItem setHidesBackButton:YES];
        [loginViewController setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    else {
        
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
