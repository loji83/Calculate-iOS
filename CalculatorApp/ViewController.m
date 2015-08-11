//
//  ViewController.m
//  CalculatorApp
//
//  Created by Kang on 2015. 7. 15..
//  Copyright (c) 2015년 Kang. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize curValue;
@synthesize totalValue;
@synthesize curStatusCode;
@synthesize displayLabel;
@synthesize displayAnswer;



- (void)viewDidLoad {
    [self ClearCalculation];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


-(void)DisplayInputValue:(NSString *)displayText
{

    NSString *CommaText;
    CommaText = [self ConvertComma:displayText];

    [displayLabel setText:CommaText];
}

-(void)DisplayAnswerValue:(NSString *)displayText
{
    NSString *CommaText;
    CommaText = [self ConvertComma:displayText];
    [displayAnswer setText:CommaText];
}

-(void)DisplayCalculationValue
{
    NSString *displayText;
    displayText = [NSString stringWithFormat:@"%g", totalCurValue];
    [self DisplayAnswerValue:displayText];
    curInputValue =@"";
}

-(void)ClearCalculation
{
    curInputValue=@"";
    curValue = 0;
    totalValue = 0;
    
    [self DisplayInputValue:curInputValue];
    [self DisplayCalculationValue];
    
    curStatusCode = STATUS_DEFAULT;
}

-(NSString *) ConvertComma:(NSString *) data
{
    if(data == nil) return nil;
    if([data length] <= 3)
    {
        return data;
    }
    
    NSString *integerString = nil;
    NSString *floatString = nil;
    NSString *minusString = nil;
    
    NSRange pointRange = [data rangeOfString:@"."];
    if(pointRange.location == NSNotFound){
        integerString = data;
    }else
    {
        NSRange r;
        r.location = pointRange.location;
        r.length = [data length] - pointRange.location;
        floatString = [data substringWithRange:r];
       
        r.location = 0;
        r.length = pointRange.location;
        integerString = [data substringWithRange:r];
    }
    
    NSRange minusRange = [integerString rangeOfString:@"-"];
    if(minusRange.location != NSNotFound){
        minusString = @"-";
        integerString = [integerString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSMutableString *integerStringCommaInserted = [[NSMutableString alloc] init];
    int integerStringLength = (int)[integerString length];
    int idx = 0;
    while(idx<integerStringLength)
    {
        [integerStringCommaInserted appendFormat:@"%C", [integerString characterAtIndex:idx]];
        if((integerStringLength - (idx+1)) % 3 == 0 && integerStringLength != (idx +1))
        {
            [integerStringCommaInserted appendString:@","];
        }
        idx++;
    }
    
    NSMutableString *returnString = [[NSMutableString alloc] init];
    if(minusString != nil)
    {
        [returnString appendString:minusString];
    }
    if(integerStringCommaInserted != nil)
    {
        [returnString appendString:integerStringCommaInserted];
    }
    if(floatString != nil)
    {
        [returnString appendString:floatString];
    }
   
    return returnString;
}




-(IBAction)digitPressed:(UIButton *)sender
{
    NSString *numPoint = [[sender titleLabel] text];
    curInputValue = [curInputValue stringByAppendingString:numPoint];
    [self DisplayInputValue:curInputValue];
    
}

-(IBAction)operationPressed:(UIButton *)sender
{
    NSString *operationText = [[sender titleLabel] text];
    if([@"+" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_PLUS];
    }else if([@"-" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MINUS];
    }else if([@"X" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_MULTIPLY];
    }else if([@"/" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_DIVISION];
    }else if([@"=" isEqualToString:operationText])
    {
        [self Calculation:curStatusCode CurStatusCode:STATUS_RETURN];
    }else if([@"C" isEqualToString:operationText])
    {
        [self ClearCalculation];
    }
    
}

-(void) Calculation:(kStatusCode)StatusCode CurStatusCode:(kStatusCode)cStatusCode;
{
    switch(StatusCode)
    {
        case STATUS_DEFAULT:
            [self DefaultCalculation];
            break;
        case STATUS_DIVISION:
            [self DivisionCalculation];
            break;
        case STATUS_MULTIPLY:
            [self MultiplyCalculation];
            break;
        case STATUS_MINUS:
            [self MinusCalculation];
            break;
        case STATUS_PLUS:
            [self PlusCalculation];
            break;
    }
    
    curStatusCode = cStatusCode;
    
}

-(void)DefaultCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = curValue;
    
    [self DisplayCalculationValue];
}


-(void)PlusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue + curValue;
    
    [self DisplayCalculationValue];
}

-(void)MinusCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue - curValue;
    
    [self DisplayCalculationValue];
}

-(void)DivisionCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue / curValue;
    
    [self DisplayCalculationValue];
}

-(void)MultiplyCalculation
{
    curValue = [curInputValue doubleValue];
    totalCurValue = totalCurValue * curValue;
    
    [self DisplayCalculationValue];
}






@end
