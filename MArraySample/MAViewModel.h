//
//  MAViewModel.h
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/24.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MAViewModel : NSObject
// Text
@property (nonatomic, copy) NSString* textCount;
- (void)textAddCard;
- (void)textRemoveCard;
// Fail NSMutableArray
@property (nonatomic) NSMutableArray* fDeck;
- (void)fAddCard;
// KVO 1
@property (nonatomic) NSMutableArray* kvo1dummyDeck;
@property (nonatomic) NSMutableArray* kvo1Deck;
- (void)kvo1AddCard;
- (void)kvo1RemoveCard;
// KVO 2
@property (nonatomic) NSMutableArray* kvo2Deck;
- (void)kvo2AddCard;
- (void)kvo2RemoveCard;
// RAC
@property (nonatomic, copy) NSString* racCard;
@property (nonatomic) RACSubject* racCardAdded;
@property (nonatomic) RACSubject* racCardRemoved;
- (void)racAddCard;
- (void)racRemoveCard;
// Misc
- (NSString*)cardTitle:(NSArray*)deck;
@end
