//
//  MAViewModel.m
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/24.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

#import "MAViewModel.h"
#import "MACard.h"

@interface MAViewModel()
// Text
@property (nonatomic) NSUInteger textNum;
@property (nonatomic) NSMutableArray* textDeck;
// Fail NSMutableArray
@property (nonatomic) NSUInteger fNum;
@end

@implementation MAViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Text
        _textNum = 0;
        _textDeck = [@[] mutableCopy];
        self.textCount = [self textDeckCount];
        // Fail NSMutableArray
        _fNum = 0;
        _fDeck = [@[] mutableCopy];
        return self;
    }
    return self;
}

#pragma mark - Text

- (void)textAddCard
{
    [self.textDeck addObject:[[MACard alloc] initWithInteger:_textNum++]];
    self.textCount = [self textDeckCount];
}

- (void)textRemoveCard
{
    [self.textDeck removeLastObject];
    _textNum--;
    self.textCount = [self textDeckCount];
}

- (NSString *)textDeckCount
{
    return [NSString stringWithFormat:@"%lu", self.textDeck.count];
}

#pragma mark - Fail NSMutableArray

- (void)fAddCard
{
    [self.fDeck addObject:[[MACard alloc] initWithInteger:_fNum++]];
}

@end
