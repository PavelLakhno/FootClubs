//
//  PLQuizFlagVC.m
//  FlagsOfCountries
//
//  Created by Павел Лахно on 16.05.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import "PLQuizFlagVC.h"
#import "PLFlagsDictionary.h"
#import "PLQuestion.h"

@interface PLQuizFlagVC ()

@property (nonatomic, copy) NSDictionary *flagNamesAndCodes;
@property (nonatomic, copy) NSArray *flagNames;
@property (nonatomic, copy) NSArray *flagCodes;
@property (nonatomic, strong) NSString *correctAnswer;
@property (strong, nonatomic) NSArray *questionArray;

@end

@implementation PLQuizFlagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.correctAnswer = [[NSString alloc] init];
    [self initQuestion];
    

    [self callQuestion];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HelpFunction
/*
- (void) initDictionary {
    
    PLFlagsDictionary *flagDictionaryClass = [[PLFlagsDictionary alloc] init];
    _flagNamesAndCodes = [flagDictionaryClass flagArray];
    _flagNames = [_flagNamesAndCodes allValues];
    _flagCodes = [_flagNamesAndCodes allKeys];
    
}
 */
- (void) initQuestion {
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"level1" ofType:@"plist"]];
    
    NSMutableArray *questionArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        PLQuestion *question = [PLQuestion questionWithDict:dict];
        [questionArray addObject:question];
    }
    self.questionArray = [NSArray arrayWithArray:questionArray];
}

- (PLQuestion*) random {
    
    //NSString * randomArray = self.flagCodes[arc4random_uniform((UInt32)self.flagCodes.count)];
    PLQuestion *question = self.questionArray[arc4random_uniform((UInt32)self.questionArray.count)];
    //NSString *imgName = question.icon;
    return question;
}
/*
- (void) randomer {
    
    NSString *imageName = [[NSString alloc] initWithString:[self random]];
    
    self.imageFlag.image = [UIImage imageNamed:imageName];
    self.correctAnswer = [_flagNamesAndCodes valueForKey:imageName];
    NSLog(@"%@", [_flagNamesAndCodes valueForKey:imageName]);
    
    NSString *answ1 = [_flagNamesAndCodes objectForKeyedSubscript:imageName];
    NSString *answ2 = [_flagNamesAndCodes objectForKeyedSubscript:[[NSString alloc] initWithString:[self random]]];
    NSString *answ3 = [_flagNamesAndCodes objectForKeyedSubscript:[[NSString alloc] initWithString:[self random]]];
    NSString *answ4 = [_flagNamesAndCodes objectForKeyedSubscript:[[NSString alloc] initWithString:[self random]]];
    
    NSMutableArray *randArray = [NSMutableArray arrayWithObjects:answ1, answ2, answ3, answ4, nil];
    
    for (NSInteger x=0; x < [randArray count]; x++) {
        NSInteger randInt = (arc4random() % ([randArray count] - x)) + x;
        [randArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    [self.answer1 setTitle:[randArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.answer2 setTitle:[randArray objectAtIndex:1] forState:UIControlStateNormal];
    [self.answer3 setTitle:[randArray objectAtIndex:2] forState:UIControlStateNormal];
    [self.answer4 setTitle:[randArray objectAtIndex:3] forState:UIControlStateNormal];
    
}
*/

- (void) callQuestion {
    
    PLQuestion *question = [self random];
    
    NSString *imageName = question.icon;
    
    self.imageFlag.image = [UIImage imageNamed:imageName];
    self.correctAnswer = question.answer;
    
    NSString *answ1 = self.correctAnswer;
    
    PLQuestion *question2 = [self random];
    PLQuestion *question3 = [self random];
    PLQuestion *question4 = [self random];
    
    NSString *answ2 = question2.answer;
    NSString *answ3 = question3.answer;
    NSString *answ4 = question4.answer;
    
    NSMutableArray *randArray = [NSMutableArray arrayWithObjects:answ1, answ2, answ3, answ4, nil];
    
    for (NSInteger x=0; x < [randArray count]; x++) {
        NSInteger randInt = (arc4random() % ([randArray count] - x)) + x;
        [randArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    
    [self.answer1 setTitle:[randArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.answer2 setTitle:[randArray objectAtIndex:1] forState:UIControlStateNormal];
    [self.answer3 setTitle:[randArray objectAtIndex:2] forState:UIControlStateNormal];
    [self.answer4 setTitle:[randArray objectAtIndex:3] forState:UIControlStateNormal];
    
}

- (IBAction)actionPressBtn:(UIButton *)sender {

    if (sender.tag == 1) {
        if ([self.answer1.titleLabel.text isEqualToString: self.correctAnswer]) {
            NSLog(@"Correct");
        } else NSLog(@"Wrong");
        
    }
    else if (sender.tag == 2) {
        if ([self.answer2.titleLabel.text isEqualToString: self.correctAnswer]) {
            NSLog(@"Correct");
        } else NSLog(@"Wrong");
    }
    else if (sender.tag == 3) {
        if ([self.answer3.titleLabel.text isEqualToString: self.correctAnswer]) {
            NSLog(@"Correct");
        } else NSLog(@"Wrong");
    }
    else if (sender.tag == 4) {
        if ([self.answer4.titleLabel.text isEqualToString: self.correctAnswer]) {
            NSLog(@"Correct");
        } else NSLog(@"Wrong");
    }
    [self callQuestion];
    
}


@end
