//
//  ViewController.m
//  MessageFirebase
//
//  Created by Павел Лахно on 15.11.17.
//  Copyright © 2017 Павел Лахно. All rights reserved.
//

#import "PLLogInVC.h"
#import "ProgressHUD.h"
#import "PLDataService.h"

@interface PLLogInVC ()

@end

@implementation PLLogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *dismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];//
    dismissKeyboard.numberOfTapsRequired = 1;//
    [self.view addGestureRecognizer:dismissKeyboard];
    
}

#pragma mark - Action
- (IBAction)actionLogIn:(UIButton *)sender {
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([email isEqualToString:@""] || [password isEqualToString:@""] ) {
        
        [ProgressHUD showError:@"Email/Password can't be empty"];
        return;
    }
    
    //NSData *data = [[NSData alloc] init];
    //data = UIImageJPEGRepresentation(self.profileImage.image, 0.1);
    
    //Sign Up
    [ProgressHUD show:@"Signing in..." Interaction:NO];
    PLDataService *dataService = [[PLDataService alloc] init];
    //[dataService logInWithEmail:email andPassword:password]; !!!!!!!!!
    
}

- (void) dismissKeyboard:(UITapGestureRecognizer* ) tap {
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
