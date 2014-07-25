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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textCount;
- (IBAction)textChangeCard:(id)sender;
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
@end
