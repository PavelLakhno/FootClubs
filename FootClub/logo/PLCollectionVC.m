//
//  PLCollectionVC.m
//  FootClub
//
//  Created by Павел Лахно on 13.08.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import "PLCollectionVC.h"
#import "PLCollectionViewCell.h"
#import "PLQuestion.h"
#import "PLGuessTeam.h"

@interface PLCollectionVC () <UICollectionViewDataSource, UICollectionViewDelegate, PLGuessDelegate>

@property (strong, nonatomic) NSMutableArray *arrImages;

//@property (strong, nonatomic) PLQuestion *question;


@end

@implementation PLCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.arrImages) {
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"level1" ofType:@"plist"]];
        
        NSMutableArray *questionArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            PLQuestion *question = [PLQuestion questionWithDict:dict];
            [questionArray addObject:question];

        }
        NSLog(@"%@", questionArray);
        
        self.arrImages = [[NSMutableArray alloc] initWithArray:questionArray];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PLQuestion *question = self.arrImages[indexPath.row];

    cell.teamImage.image = [UIImage imageNamed:question.icon];

    NSLog(@"%d", question.guess);
    if (question.guess == true) {
        [cell.littleImage setImage:[UIImage imageNamed:@"ok.png"]];
    } else {
        cell.littleImage.image = nil;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PLGuessTeam *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PLGuessTeam"];
    vc.question = self.arrImages[indexPath.row];
    vc.delegate = self;
    vc.indexPath = indexPath;

    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) guessWord:(PLQuestion *) question withIndex:(NSIndexPath *) index {

    for (PLQuestion *question in self.arrImages) {
        NSLog(@"%@ - %d",question.answer, question.guess);
    }
    
    [self.collectionView reloadData];
}


@end
