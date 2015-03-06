//
//  MKImageMarkup.h
//  Inkpad
//
//  Created by Manju Kiran on 23/02/2015.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2015 Manju Kiran
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WDCanvasController.h"

//! Project version number for MKImageMarkup.
FOUNDATION_EXPORT double MKImageMarkupVersionNumber;

//! Project version string for MKImageMarkup.
FOUNDATION_EXPORT const unsigned char MKImageMarkupVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MKImageMarkup/PublicHeader.h>


@protocol MKImageMarkupDelegate <NSObject>
@required
-(void)didDismissMarkupSessionWithImage:(UIImage*)image imageEdited:(BOOL)imageEdited;
@end


@interface MKImageMarkup : NSObject <UINavigationControllerDelegate,
                                    UIImagePickerControllerDelegate,
                                    UIPopoverControllerDelegate,
                                    UIActionSheetDelegate,
                                    WDCanvasControllerDelegate>

@property (nonatomic,weak)      id <MKImageMarkupDelegate> delegate;

-(instancetype) initPopOverInViewController:(UIViewController*)viewController
                                 fromButton:(UIButton*)button;

-(void) startEditingImage:(UIImage*)image sourceViewController:(UIViewController*)sourceVC;

@end





