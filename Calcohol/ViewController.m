//
//  ViewController.m
//  Calcohol
//
//  Created by Steven Schofield on 03/07/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *sliderLabel;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *beerImage;


@end

@implementation ViewController

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocation and initialize each of our views and the gesture recognizer
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    UILabel *sliderLabel = [[UILabel alloc] init];
    UIImageView *beerImage = [[UIImageView alloc] init];
    
    // Add each view and the gesture recognizer as view's subviews
    [self.view addSubview:scrollView];
    // Subviews
    [scrollView addSubview:textField];
    [scrollView addSubview:slider];
    [scrollView addSubview:label];
    [scrollView addSubview:button];
    [scrollView addGestureRecognizer:tap];
    [scrollView addSubview:sliderLabel];
    [scrollView addSubview:beerImage];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    self.sliderLabel = sliderLabel;
    self.beerImage = beerImage;
    self.scrollView = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPercentTextField.textAlignment = NSTextAlignmentCenter;
    
    [self.beerPercentTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Style slider
    self.beerCountSlider.tintColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:1];
    
    // Style Beer Icons
    self.beerImage.image = [self.beerImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.beerImage setTintColor:[UIColor whiteColor]];
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.calculateButton.backgroundColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1]; /*#3498db*/
    self.calculateButton.titleLabel.font = [UIFont systemFontOfSize:28];
    
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.textColor = [UIColor whiteColor];
    
    // set the slider label style
    self.sliderLabel.text = @"0";
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

- (void) viewDidLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect screenRect = self.view.frame;
    self.scrollView.frame = screenRect;
    self.scrollView.contentSize = CGSizeMake(screenRect.size.width, 568);
    
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding * 2, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerImage.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.sliderLabel.frame = CGRectMake(padding, bottomOfSlider + (padding / 2), itemWidth, itemHeight);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(0, bottomOfLabel + padding, viewWidth, itemHeight * 1.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0 ) {
        sender.text = nil;
    }
}
- (void)sliderValueDidChange:(UISlider *)sender {
    
    int numberOfBeers = self.beerCountSlider.value;
    NSString *beerText;
    [self setBeerText:&beerText numberOfBeers:numberOfBeers];
    
    NSString *sliderValue = [NSString stringWithFormat:@"%.lf %@", sender.value, beerText];
    self.sliderLabel.text = sliderValue;
    [self.beerPercentTextField resignFirstResponder];
    
}
- (void)setBeerText:(NSString **)beerText_p numberOfBeers:(int)numberOfBeers {
    
    
    if (numberOfBeers == 1) {
        *beerText_p = NSLocalizedString(@"beer", @"singular beer");
    } else {
        *beerText_p = NSLocalizedString(@"beers", @"plural of beer");
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)buttonPressed:(UIButton *)sender {
    
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSString *beerText;
    [self setBeerText:&beerText numberOfBeers:numberOfBeers];
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText;
    if (alcoholPercentageOfBeer == 0) {
        resultText = @"Please input the Alcohol Percentage";
    } else {
        resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.lf %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    }
    self.resultLabel.text = resultText;
    
    
}
- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
