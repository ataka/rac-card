//
//  MACard.h
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/23.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

@import Foundation;

@interface MACard : NSObject
@property (nonatomic, readonly) NSInteger num;
@property (nonatomic, readonly, copy) NSString* title;
- (instancetype)initWithInteger:(NSUInteger)num;
@end
