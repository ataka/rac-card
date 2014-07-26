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
// KVO 1
@property (nonatomic) NSUInteger kvo1Num;
// KVO 2
@property (nonatomic) NSUInteger kvo2Num;
// RAC
@property (nonatomic) NSUInteger racNum;
@property (nonatomic) NSMutableArray* racDeck;
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
        // KVO 1
        _kvo1Num = 0;
        _kvo1dummyDeck = [@[] mutableCopy];
        [self addObserver:self forKeyPath:@"kvo1dummyDeck" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        _kvo1Deck = [self mutableArrayValueForKey:@"kvo1dummyDeck"];
        // KVO 2
        _kvo2Num = 0;
        _kvo2Deck = [@[] mutableCopy];
        [self addObserver:self forKeyPath:@"kvo2Deck" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        // RAC
        _racNum = 0;
        _racDeck = [@[] mutableCopy];
        self.racCardAdded = [RACSubject subject];
        self.racCardRemoved = [RACSubject subject];
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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

#pragma mark - KVO 1

- (void)kvo1AddCard
{
    [self.kvo1Deck addObject:[[MACard alloc] initWithInteger:_kvo1Num++]];
}

- (void)kvo1RemoveCard
{
    if (_kvo1Deck.count == 0) {
        return;
    }
    [self.kvo1Deck removeLastObject];
    _kvo1Num--;
}

#pragma mark - KVO 2

- (void)kvo2AddCard
{
    [[self mutableArrayValueForKey:@"kvo2Deck"] addObject:[[MACard alloc] initWithInteger:_kvo2Num++]];
}

- (void)kvo2RemoveCard
{
    if (_kvo2Deck.count == 0) {
        return;
    }
    [[self mutableArrayValueForKey:@"kvo2Deck"] removeLastObject];
    _kvo2Num--;
}

#pragma mark - RAC

- (void)racAddCard
{
    [self.racDeck addObject:[[MACard alloc] initWithInteger:_racNum++]];
    [self.racCardAdded sendNext:((MACard*)self.racDeck.lastObject).title];
}

- (void)racRemoveCard
{
    if (_racDeck.count == 0) {
        return;
    }
    [self.racDeck removeLastObject];
    [self.racCardRemoved sendNext:((MACard*)self.racDeck.lastObject).title];
    _racNum--;
    
}

#pragma mark - Misc

- (NSString*)cardTitle:(NSArray*)deck
{
    if (deck.count == 0) {
        return @"";
    }
    return ((MACard *)deck.lastObject).title;
}

@end
