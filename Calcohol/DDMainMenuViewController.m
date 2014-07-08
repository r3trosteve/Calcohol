//
//  DDMainMenuViewController.m
//  Calcohol
//
//  Created by Steven Schofield on 07/07/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "DDMainMenuViewController.h"

@interface DDMainMenuViewController ()

@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation DDMainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *wineButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    UIButton *whiskeyButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    // UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:wineButton];
    [self.view addSubview:whiskeyButton];
    // [self.view addSubview:newView];
    
    // newView.backgroundColor = [UIColor whiteColor];
    
    self.whiskeyButton = whiskeyButton;
    self.wineButton = wineButton;

    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine!", @"Go to Wine") forState:UIControlStateNormal];
    [self.wineButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.wineButton.backgroundColor = [UIColor whiteColor];
    
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey!", @"Go to Whiskey") forState:UIControlStateNormal];
    [self.whiskeyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.whiskeyButton.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedString(@"Select Calcoholator", nil);

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.whiskeyButton.frame = CGRectMake(20, 180, 100, 44);
    self.wineButton.frame = CGRectMake(180, 180, 100, 44);
    
}

- (void) winePressed:(UIButton *) sender {
    DDViewController *wineVC = [[DDViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    DDWhiskeyViewController *whiskeyVC = [[DDWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

@end
