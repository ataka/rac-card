//
//  ViewController.m
//  MArraySample
//
//  Created by 安宅 正之 on 2014/07/23.
//  Copyright (c) 2014年 MasayukiAtaka. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MAViewModel.h"

#import "MACard.h"

@interface ViewController ()
// Text
@property (weak, nonatomic) IBOutlet UILabel *textCount;
- (IBAction)textChangeCard:(id)sender;
// Fail NSMutableArray
@property (weak, nonatomic) IBOutlet UILabel *fCard;
- (IBAction)fAddCard:(id)sender;
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
}

#pragma mark - IBAction

- (IBAction)textChangeCard:(id)sender {
    UIStepper* stepper = (UIStepper*)sender;
    NSLog(@"%d", (int)stepper.value);
    static NSInteger val = 0;
    NSInteger value = (NSInteger)stepper.value;
    
    if (value > val) {
        [self.viewModel textAddCard];
    } else {
        [self.viewModel textRemoveCard];
    }
    val = value;
}
- (IBAction)fAddCard:(id)sender {
    [self.viewModel fAddCard];
}
@end
