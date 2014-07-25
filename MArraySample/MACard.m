//
//  MACard.m
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/23.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

#import "MACard.h"

@implementation MACard

const static NSUInteger deckNum = 53;

- (instancetype)init
{
    return [[MACard alloc] initWithInteger:1];
}

- (instancetype)initWithInteger:(NSUInteger)num
{
    self = [super init];
    if (self) {
        _num = num % deckNum;
        _title = [self createCardTitle:num];
        return self;
    }
    return self;
}

- (NSString*)createCardTitle:(NSUInteger)num
{
    const static NSUInteger suitNum = 13;
    const NSArray* suitSimbol = @[@"♠︎", @"♡", @"♣︎", @"♢"];
    NSUInteger suit = _num / suitNum;
    NSUInteger n = _num % suitNum;
    
    if (_num == deckNum - 1) {
        return @"JK";  // Joker
    }
    return [NSString stringWithFormat:@"%@%@", suitSimbol[suit], [self candNum:n]];
}

- (NSString*)candNum:(NSUInteger)num
{
    NSUInteger n = num+1;
    switch (n) {
        case 1:
            return @"A";
        case 11:
            return @"J";
        case 12:
            return @"Q";
        case 13:
            return @"K";
        default:
            // FALLTHROUGHT
            break;
    }
    return [NSString stringWithFormat:@"%lu", n];
}

@end
