//
//  PLQuestion.h
//  FootClub
//
//  Created by Павел Лахно on 25.07.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLQuestion : NSObject

@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,strong) NSArray *options;
@property (nonatomic, assign) BOOL guess;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) questionWithDict:(NSDictionary *)dict;

@end
