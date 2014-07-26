//
//  ViewController.m
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/23.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "ViewController.h"

#import "MAViewModel.h"

#import "MACard.h"

@interface ViewController ()
// Text
@property (weak, nonatomic) IBOutlet UILabel *textCount;
- (IBAction)textAddCard:(id)sender;
- (IBAction)textRemoveCard:(id)sender;
// Fail NSMutableArray
@property (weak, nonatomic) IBOutlet UILabel *fCard;
- (IBAction)fAddCard:(id)sender;
// KVO 1
@property (weak, nonatomic) IBOutlet UILabel *kvo1Card;
- (IBAction)kvo1AddCard:(id)sender;
- (IBAction)kvo1RemoveCard:(id)sender;
// KVO 2
@property (weak, nonatomic) IBOutlet UILabel *kvo2Card;
- (IBAction)kvo2AddCard:(id)sender;
- (IBAction)kvo2RemoveCard:(id)sender;

// ViewModel
@property (nonatomic) MAViewModel* viewModel;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MAViewModel alloc] init];
    [self prepareRAC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReactiveCocoa

- (void)prepareRAC
{
    RAC(self.textCount, text) = RACObserve(self.viewModel, textCount);
    
    RAC(self.fCard, text) = [RACObserve(self.viewModel, fDeck) map:^NSString*(NSMutableArray* mArray) {
        return ((MACard*)mArray.lastObject).title;
    }];

    @weakify(self);
    RACSignal* kvo1Signal = [self.viewModel rac_valuesAndChangesForKeyPath:@"kvo1dummyDeck"
                                                                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                                                  observer:self.viewModel];
    [kvo1Signal subscribeNext:^(RACTuple* tuple) {
        NSArray* wholeArray = tuple.first;
        NSDictionary* changes = tuple.second;
        NSArray* oldArray = changes[NSKeyValueChangeOldKey];
        NSArray* newArray = changes[NSKeyValueChangeNewKey];
        
        @strongify(self);
        if (newArray.count > oldArray.count) {
            self.kvo1Card.text = ((MACard*)newArray[0]).title;
        } else {
            self.kvo1Card.text = ((MACard*)wholeArray.lastObject).title;
        }
    }];
    
    RACSignal* kvo2Signal = [self.viewModel rac_valuesAndChangesForKeyPath:@"kvo2Deck"
                                                                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                                                  observer:self.viewModel];
    [kvo2Signal subscribeNext:^(RACTuple* tuple) {
        NSArray* wholeArray = tuple.first;
        NSDictionary* changes = tuple.second;
        NSArray* oldArray = changes[NSKeyValueChangeOldKey];
        NSArray* newArray = changes[NSKeyValueChangeNewKey];
        
        @strongify(self);
        if (newArray.count > oldArray.count) {
            self.kvo2Card.text = ((MACard*)newArray[0]).title;
        } else {
            self.kvo2Card.text = ((MACard*)wholeArray.lastObject).title;
        }
    }];
}

#pragma mark - IBAction

- (IBAction)textAddCard:(id)sender {
    [self.viewModel textAddCard];
}
- (IBAction)textRemoveCard:(id)sender {
    [self.viewModel textRemoveCard];
}


- (IBAction)fAddCard:(id)sender {
    [self.viewModel fAddCard];
}


- (IBAction)kvo1AddCard:(id)sender {
    [self.viewModel kvo1AddCard];
}
- (IBAction)kvo1RemoveCard:(id)sender {
    [self.viewModel kvo1RemoveCard];
}


- (IBAction)kvo2AddCard:(id)sender {
    [self.viewModel kvo2AddCard];
}
- (IBAction)kvo2RemoveCard:(id)sender {
    [self.viewModel kvo2RemoveCard];
}
@end
