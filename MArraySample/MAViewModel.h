//
//  MAViewModel.h
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/24.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

@import Foundation;

@interface MAViewModel : NSObject
// Text
@property (nonatomic, copy) NSString* textCount;
- (void)textAddCard;
- (void)textRemoveCard;
@end
