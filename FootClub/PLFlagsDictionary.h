//
//  PLFlagsDictionary.h
//  FlagsOfCountries
//
//  Created by Павел Лахно on 01.08.17.
//  Copyright © 2017 Павел Лахно. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLFlagsDictionary : NSObject

-(NSDictionary *)flagArray;

-(NSDictionary *)flagArrayWithString:(NSString*) continent;

@end
