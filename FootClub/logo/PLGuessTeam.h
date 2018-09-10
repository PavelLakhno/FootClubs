//
//  PLGuessTeam.h
//  FootClub
//
//  Created by Павел Лахно on 25.07.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLQuestion;
@protocol PLGuessDelegate;

@interface PLGuessTeam : UIViewController

@property (strong, nonatomic) PLQuestion *question;
@property (weak, nonatomic) id <PLGuessDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@protocol PLGuessDelegate <NSObject>

- (void) guessWord:(PLQuestion *) question withIndex:(NSIndexPath *) index;

@end
