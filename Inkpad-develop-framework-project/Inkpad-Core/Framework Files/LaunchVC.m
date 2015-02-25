//
//  LaunchVC.m
//  Inkpad
//
//  Created by Manju Kiran on 23/02/2015.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2015 Manju Kiran


#import "LaunchVC.h"

@interface LaunchVC ()
@property (nonatomic, strong) MKImageMarkup *mkIM;
@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mainButtonTouched:(id)sender {
    self.mkIM = [[MKImageMarkup alloc] initPopOverInViewController:self
                                                                 fromButton:sender];
    self.mkIM.delegate = self;
}

-(void)didDismissMarkupSessionWithImage:(UIImage*)image imageEdited:(BOOL)imageEdited{
//    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
//    [iv setFrame:CGRectMake(20.0, 20.0, image.size.width, image.size.height)];
//    [self.view addSubview:iv];
}

@end
