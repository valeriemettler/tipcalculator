//
//  ViewController.m
//  TipCalculator
//
//  Created by Val on 10/18/14.
//  Copyright (c) 2014 Val. All rights reserved.
//

#import "ViewController.h"
//UITextFieldDelegate
@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (assign, nonatomic) CGFloat tipPercentage;

- (IBAction)tipPercentageChanged:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipPercentageChanged:(UISegmentedControl*)sender
{
    CGFloat tipPercentage = 0;
    switch (sender.selectedSegmentIndex){
        case 0:
            tipPercentage = 0.1;
            break;
        case 1:
            tipPercentage = 0.15;
            break;
        case 2:
            tipPercentage = 0.2;
        default:
            break;
            
    }
    
    self.tipPercentage = tipPercentage;
    [self calculateNewTipAndTotal];
}

            
- (void)calculateNewTipAndTotal {
    CGFloat currentBill = [self.amountField.text floatValue];
    CGFloat newTipAmount = currentBill * self.tipPercentage;
    CGFloat newTotal = currentBill+ newTipAmount;
    [self updateLabelsToTipAmount:newTipAmount total:newTotal];
}


- (void)doneButtonPressed {
    [self calculateNewTipAndTotal];
    [self.amountField resignFirstResponder];
}
             
- (void)updateLabelsToTipAmount:(CGFloat)tip total: (CGFloat)total
{
    // [self updateLabelsToTipAmount:5.0 total:30.0]
    self.amountLabel.text = [NSString stringWithFormat:@"$%0.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                  UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
}
@end
