//
//  PLQuizFlagVC.h
//  FlagsOfCountries
//
//  Created by Павел Лахно on 16.05.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLQuizFlagVC : UIViewController

- (IBAction)actionPressBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *answer4;


@property (weak, nonatomic) IBOutlet UIImageView *imageFlag;

@end
