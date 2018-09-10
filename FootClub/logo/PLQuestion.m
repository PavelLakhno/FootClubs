//
//  PLQuestion.m
//  FootClub
//
//  Created by Павел Лахно on 25.07.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import "PLQuestion.h"

@implementation PLQuestion

- (instancetype) initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
        self.answer = dict[@"answer"];
        self.options = dict[@"options"];
        self.guess = NO;
    }
    return self;
}


+(instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
