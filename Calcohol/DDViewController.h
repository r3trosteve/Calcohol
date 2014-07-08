//
//  ViewController.h
//  Calcohol
//
//  Created by Steven Schofield on 03/07/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;

- (void)buttonPressed:(UIButton *)sender;
- (NSString *)setBeerText:(int)numberOfBeers;


@end

