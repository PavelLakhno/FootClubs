//
//  SignUpVC.h
//  MessageFirebase
//
//  Created by Павел Лахно on 15.11.17.
//  Copyright © 2017 Павел Лахно. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLSignUpVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (IBAction)actionCancel:(UIButton *)sender;
- (IBAction)actionSignUp:(UIButton *)sender;

@end
