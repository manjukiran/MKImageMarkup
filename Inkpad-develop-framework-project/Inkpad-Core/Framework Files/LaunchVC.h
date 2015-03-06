//
//  LaunchVC.h
//  Inkpad
//
//  Created by Manju Kiran on 23/02/2015.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2015 Manju Kiran

#import <UIKit/UIKit.h>
#import "MKImageMarkup.h"

@interface LaunchVC : UIViewController <MKImageMarkupDelegate>

- (IBAction)mainButtonTouched:(id)sender;

@end
