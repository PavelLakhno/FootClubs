//
//  PLFlagsDictionary.m
//  FlagsOfCountries
//
//  Created by Павел Лахно on 01.08.17.
//  Copyright © 2017 Павел Лахно. All rights reserved.
//

#import "PLFlagsDictionary.h"

@interface PLFlagsDictionary ()

@property (nonatomic, copy) NSMutableDictionary *replaceNameAndKey;

@end

@implementation PLFlagsDictionary

-(NSDictionary *)flagArray {
    
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PremierLiga"
                                                         ofType:@"json"];
    NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataFromFile
                                                         options:kNilOptions
                                                           error:&error];
    if (error != nil) {
        NSLog(@"Error: was not able to load countries.");
        return nil;
    }
    
    NSLog(@"%@", data);
    
    return data;
    
}

-(NSDictionary *)flagArrayWithString:(NSString*) continent {
    
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:continent
                                                         ofType:@"json"];
    NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataFromFile
                                                         options:kNilOptions
                                                           error:&error];
    if (error != nil) {
        NSLog(@"Error: was not able to load countries.");
        return nil;
    }
    
    NSDictionary *dicNew = [[NSDictionary alloc] init];
    dicNew = [self changeKeyAndValueByPlace:data];
    
    return dicNew;
    
}

- (NSMutableDictionary *) changeKeyAndValueByPlace: (NSDictionary *) dictionary {
    
    NSMutableDictionary *dicNew = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i< dictionary.count; i++) {
        
        [dicNew setValue:[dictionary allKeys][i] forKey:[dictionary allValues][i]];
        
    }
    
    
    return dicNew;
}

- (NSArray *) sortDescriptor:(NSArray *) sortArray {
    
    NSMutableArray *arrayNew = [NSMutableArray arrayWithArray:sortArray];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    
    [arrayNew sortUsingDescriptors:@[sortDescriptor]];
    
    return arrayNew;
    
}

@end
