//
//  ViewController.h
//  CalculatorApp
//
//  Created by Kang on 2015. 7. 15..
//  Copyright (c) 2015년 Kang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    STATUS_DEFAULT=0,
    STATUS_DIVISION,
    STATUS_MULTIPLY,
    STATUS_MINUS,
    STATUS_PLUS,
    STATUS_RETURN
} kStatusCode;

@interface ViewController : UIViewController {
    double curValue;
    double totalCurValue;
    NSString *curInputValue;
    kStatusCode curStatusCode;
}


-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;

@property Float64 curValue;
@property Float64 totalValue;
@property kStatusCode curStatusCode;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayAnswer;


@end

