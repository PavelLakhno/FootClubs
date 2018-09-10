//
//  SignUpVC.m
//  MessageFirebase
//
//  Created by Павел Лахно on 15.11.17.
//  Copyright © 2017 Павел Лахно. All rights reserved.
//

#import "PLSignUpVC.h"
#import "PLDataService.h"
#import "ProgressHUD.h"

@interface PLSignUpVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *selectedImage;

@end

@implementation PLSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.selectedImage = [[UIImage alloc] init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhoto:)];
    tap.numberOfTapsRequired = 1;
    [self.profileImage addGestureRecognizer:tap];
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
    self.profileImage.clipsToBounds = YES;
    
    self.userNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.selectedImage = (UIImage*)info[UIImagePickerControllerOriginalImage];
    self.profileImage.image = self.selectedImage;
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.userNameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
    
}

#pragma mark - Action

- (void) selectPhoto: (UITapGestureRecognizer*) tapGesture {
    
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (IBAction)actionCancel:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)actionSignUp:(UIButton *)sender {
    
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *username = self.userNameTextField.text;
    
    if ([email isEqualToString:@""] || [password isEqualToString:@""] || [username isEqualToString:@""]) {
        
        NSLog(@"Empty anything");
        return;
    }
    
    NSData *data = [[NSData alloc] init];
    data = UIImageJPEGRepresentation(self.profileImage.image, 0.1);
    
    //Sign Up
    [ProgressHUD show:@"Please wait..." Interaction:NO];
    PLDataService *dataService = [[PLDataService alloc] init];
    //[dataService signUp:username withEmail:email password:password andData:data]; !!!!!!!!!
    
}


@end






