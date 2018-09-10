//
//  PLGuessTeam.m
//  FootClub
//
//  Created by Павел Лахно on 25.07.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import "PLGuessTeam.h"
#import "PLQuestion.h"

@interface PLGuessTeam ()
- (IBAction)tip;
- (IBAction)bigImg;
- (IBAction)help;
- (IBAction)nextQuestion;
- (IBAction)iconClick;


@property (weak, nonatomic) IBOutlet UILabel *noLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextQuestionBtn;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *tipBtn;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@property (nonatomic,weak) UIButton *cover;

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;

@property (nonatomic,strong) NSArray *questions;
@property (nonatomic,assign) int index;
@property (nonatomic,assign) BOOL tipUse;
@end

@implementation PLGuessTeam

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = -1;
    [self nextQuestion];
    self.tipUse = NO;
    NSLog(@"%@", self.question.answer);
}

/*
- (NSArray *)questions
{
    if (_questions == nil) {
        //1.
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"level1" ofType:@"plist"]];
        //2.
        NSMutableArray *questionArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            PLQuestion *question = [PLQuestion questionWithDict:dict];
            [questionArray addObject:question];
        }
        
        //3.
        _questions = questionArray;
    }
    return _questions;
}
*/
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (IBAction)nextQuestion {
    
    //1.
    self.index++;
    //2.
    //PLQuestion *question = self.questions[self.index];
    PLQuestion *question = self.question;
    //3.
    //3.1
    self.noLable.text = [NSString stringWithFormat:@"%d/%ld",self.index+1,self.questions.count];
    //3.2
    self.titleLable.text = question.title;
    
    //3.3
    [self.iconBtn setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    
    //4
    if (self.index == self.questions.count-1) {
        [self.nextQuestionBtn setEnabled:NO];
    }
    
    //5.
    //5.1
    for (UIView *subview in self.answerView.subviews) {
        [subview removeFromSuperview];
    }
    
    //5.2
    [self addAnswerBtn:question];
    //5.3
    [self addOptionBtn:question];
    //6.
    self.tipUse = NO;
    self.tipBtn.enabled = YES;
    self.helpBtn.enabled = YES;
    if (self.index == self.questions.count) {
        self.nextQuestionBtn.enabled = NO;
    }
    
}
//answer
- (void) answerLine:(int) value withCounter:(NSInteger) counter {
    
    int length = value;
    for (int i = 0; i<length; i++) {
        UIButton *answerBtn = [[UIButton alloc]init];

        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];

        CGFloat margin = 5;
        CGFloat answerW =25;
        CGFloat answerH = 25;
        CGFloat viewW = self.view.frame.size.width;
        CGFloat leftMargin = (viewW -  length * answerW - margin*(length-1))*0.5;
        CGFloat answerX = leftMargin + i*(answerW + margin);
        answerBtn.frame = CGRectMake(answerX, counter, answerW, answerH);
        [self.answerView addSubview:answerBtn];
        [answerBtn addTarget:self action:@selector(answerClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
}

- (void) addAnswerBtn:(PLQuestion *)question
{
    NSRange range = [question.answer rangeOfString:@" "];
    NSInteger inCounter = 0;
    
    if (range.location != NSNotFound) {
        NSString *firstString = [question.answer substringToIndex:range.location];
        NSString *secondString = [question.answer substringFromIndex:range.location+1];
        NSArray *arr = [[NSArray alloc] initWithObjects:firstString,secondString, nil];
        for (int i=0; i<[arr count]; i++) {
            int length = (int)[NSString stringWithFormat:@"%@", [arr objectAtIndex:i]].length;
            [self answerLine:length withCounter:inCounter];
            inCounter = inCounter+30;
            
        }
        question.answer = [NSString stringWithFormat:@"%@%@",firstString, secondString];
    } else {
        [self answerLine:(int)question.answer.length withCounter:inCounter];
    }
    
    
}

- (void)answerClick:(UIButton *)answerBtn
{
    if ([answerBtn titleColorForState:UIControlStateNormal]==[UIColor redColor]) {
        for (UIButton *btn in self.answerView.subviews) {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        
    }
    NSString *answerTitle = [answerBtn titleForState:UIControlStateNormal];
    for(UIButton *optionBtn in self.optionView.subviews ) {
        NSString *optionTitle = [optionBtn titleForState:UIControlStateNormal];
        if ([optionTitle isEqualToString:answerTitle]) {
            optionBtn.hidden = NO;
            [answerBtn setTitle:@"" forState:UIControlStateNormal];
            break;
        }
    }
    for (UIButton *btn in self.optionView.subviews) {
        btn.enabled = YES;
    }
    
    
}
//answer

//question
- (void) addOptionBtn:(PLQuestion *)question
{
    for (UIView *subview in self.optionView.subviews) {
        [subview removeFromSuperview];
    }
    
    int count = (int)question.options.count;
    for (int i = 0; i<count; i++) {
        UIButton *optionBtn = [[UIButton alloc]init];
        //btn background
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"]forState:UIControlStateHighlighted];
        CGFloat optionW =25;
        CGFloat optionH = 25;
        CGFloat margin = 5;
        CGFloat viewW = self.view.frame.size.width;
        CGFloat leftMargin = (viewW -7*optionW-margin*6)*0.5;
        int col = i % 7;
        CGFloat optionX = leftMargin +col*(optionW+margin);
        int row = i/7;
        CGFloat optionY = row*(optionH + margin);
        
        optionBtn.frame = CGRectMake(optionX, optionY, optionW, optionH);
        //set title
        [optionBtn setTitle:question.options[i] forState:UIControlStateNormal];
        [self.optionView addSubview:optionBtn];
        
        [optionBtn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
}



- (void)optionClick:(UIButton *)optionBtn
{
    //1.
    optionBtn.hidden = YES;
    //2.
    for (UIButton *answerBtn in self.answerView.subviews) {
        
        NSString *answerTitle = [answerBtn titleForState:UIControlStateNormal];
        if (answerTitle.length == 0) {
            NSString *optionTitle = [optionBtn titleForState:UIControlStateNormal];
            [answerBtn setTitle:optionTitle forState:UIControlStateNormal];
            [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        }
        
    }
    //3.
    BOOL full = YES;
    NSMutableString *tempAnswerTitle = [NSMutableString string];
    for (UIButton *answerBtn in self.answerView.subviews) {
        NSString *answerTitle = [answerBtn titleForState:UIControlStateNormal];
        if (answerTitle.length==0) {
            full = NO;
        }
        if (answerTitle) {
            [tempAnswerTitle appendString:answerTitle];
        }
        
    }
    
    //4.
    if (full) {
        
        for (UIButton *btn in self.optionView.subviews) {
            btn.enabled =NO;
        }
        
        //PLQuestion *question = self.questions[self.index];
        PLQuestion *question = self.question;
        if ([tempAnswerTitle isEqualToString:question.answer]) {
            for (UIButton *answerBtn in self.answerView.subviews) {
                [answerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            //add score
            int score = [self.scoreBtn titleForState:UIControlStateNormal].intValue;
            score += 1000;
            [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",score] forState:UIControlStateNormal];
            //next question

            question.guess = YES;
            [self.delegate guessWord:question withIndex:self.indexPath];
            [self.navigationController popViewControllerAnimated:TRUE];
        }
        else{
            
            for (UIButton *answerBtn in self.answerView.subviews) {
                [answerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
        
    }
}

- (void)score:(NSString *)action
{
    if ([action isEqualToString:@"+"]) {
        //add score
        int score = [self.scoreBtn titleForState:UIControlStateNormal].intValue;
        score += 1000;
        [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",score] forState:UIControlStateNormal];
    }else{
        //decrease score
        int score = [self.scoreBtn titleForState:UIControlStateNormal].intValue;
        score -= 1000;
        [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",score] forState:UIControlStateNormal];
    }
}

- (IBAction)help {
    
    //1.
    for (UIButton *btn in self.answerView.subviews) {
        [self answerClick:btn];
    }
    //2.
    PLQuestion *question = self.questions[self.index];
    NSString *answer =question.answer;
    //3.
    for (int i=0; i<answer.length; i++) {
        NSString *one = [answer substringWithRange:NSMakeRange(i,1)];
        //4.
        for (UIButton *btn in self.optionView.subviews) {
            NSString *btnTitle = [btn titleForState:UIControlStateNormal];
            if ([btnTitle isEqualToString:one]) {
                [self optionClick:btn];
                break;
            }
        }
    }
    [self score:@"-"];
    [self score:@"-"];
    self.helpBtn.enabled = NO;
}

- (IBAction)tip {
    if (!self.tipUse) {
        
        for (UIButton *btn in self.answerView.subviews) {
            [self answerClick:btn];
        }
        PLQuestion *question = self.questions[self.index];
        
        NSString *aString = question.answer;
        NSString *first = [aString substringToIndex:1];
        for (UIButton *btn in self.optionView.subviews) {
            if ([btn.currentTitle isEqualToString:first]) {
                [self optionClick:btn];
                break;
            }
        }
        int score = [self.scoreBtn titleForState:UIControlStateNormal].intValue;
        score -= 500;
        [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",score] forState:UIControlStateNormal];
    }
    self.tipUse = YES;
    self.tipBtn.enabled = NO;
    
    
    
}

- (IBAction)bigImg {
    
    
    //1.
    UIButton *cover = [[UIButton alloc]init];
    self.cover = cover;
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    
    
    [cover addTarget:self action:@selector(smallImg) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cover];
    [UIView beginAnimations:nil context:nil];
    cover.alpha = 0.7;
    //2.
    [self.view bringSubviewToFront:self.iconBtn];
    
    //3.
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;;
    CGFloat iconY = (self.view.frame.size.height - iconH)*0.5;
    self.iconBtn.frame = CGRectMake(0, iconY, iconW, iconH);
    
    
    [UIView commitAnimations];
}

- (void)smallImg
{
    //delete cover
    //[self.cover removeFromSuperview];
    
    //image small
    [UIView beginAnimations:nil context:nil];
    // [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeCover)];
    self.cover.alpha = 0;
    self.iconBtn.frame = CGRectMake(85, 103, 150, 150);
    [UIView commitAnimations];
    //[self.cover removeFromSuperview];
}

- (void) removeCover
{
    [self.cover removeFromSuperview];
    self.cover = nil;
}


- (IBAction)iconClick {
    if (self.cover == nil) {
        [self bigImg];
    }
    else{
        [self smallImg];
    }
    
}




@end
