//
//  LoginViewController.m
//  Ichiban Restaurant
//
//  Created by yiqin on 7/14/14.
//  Copyright (c) 2014 yipick. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    // [self signup];
    [self.username becomeFirstResponder];
}

- (void)signup {
    PFUser *user = [PFUser user];
    // user.username
    // user.password
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginAction:(id)sender
{
    // NSLog(@"%@", self.username.text);
    // NSLog(@"%@", self.password.text);
    [SVProgressHUD show];
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSignedUp"];
                                            [self performSegueWithIdentifier: @"LoginSuccessfully" sender: self];
                                            [SVProgressHUD dismiss];
                                            
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
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
