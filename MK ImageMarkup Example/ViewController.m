//
//  ViewController.m
//  MK ImageMarkup Example
//
//  Created by Manju Kiran on 25/02/2015.
//  Copyright (c) 2015 Manju Kiran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) MKImageMarkup *mkIM;
@end

@implementation ViewController

- (IBAction)testButtonTouched:(id)sender {
    
    self.mkIM = [[MKImageMarkup alloc] initPopOverInViewController:self
                                                        fromButton:sender];
    self.mkIM.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MKImageMarkup Delegate Method

-(void)didDismissMarkupSessionWithImage:(UIImage*)image imageEdited:(BOOL)imageEdited{

    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
    [iv setFrame:CGRectMake(20.0, 20.0, self.view.frame.size.width-40.0, self.view.frame.size.height-40.0)];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:iv];
    
}

@end

