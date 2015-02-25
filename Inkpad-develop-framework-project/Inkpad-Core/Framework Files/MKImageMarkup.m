//
//  MKImageMarkup.m
//  Inkpad
//
//  Created by Manju Kiran on 23/02/2015.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2015 Manju Kiran


#import "MKImageMarkup.h"
#import "WDDrawingManager.h"
#import "WDColor.h"
#import "WDInspectableProperties.h"
#import "WDGradient.h"
#import "WDBrowserController.h"

@interface MKImageMarkup (){
    
    UIPopoverController     *popoverController_;
}

@property (nonatomic,weak)      UIButton *popOverSourceButton;
@property (nonatomic,weak)      UIViewController *presentingViewController;
@property (nonatomic,strong)    UIImagePickerController *pickerController;
@property (nonatomic,strong)    NSString *currentFileName;

-(void)startEditingDocumentWithName:(NSString*)fileName;
-(void)startEditingImage:(UIImage*)image;

@end

@implementation MKImageMarkup



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

-(instancetype)initPopOverInViewController:(UIViewController*)viewController
                                fromButton:(UIButton *)button{
    
    if(!self){
        self = [self init];
    }
    
    [self setupDefaults];

    self.presentingViewController = viewController;
    self.popOverSourceButton = (UIButton*)button;
    
    
    if([[UIDevice currentDevice].systemVersion floatValue] < 8){
        
        UIActionSheet* documentPicker = [[UIActionSheet alloc]initWithTitle:@"Select Method"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                     destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery",@"Previously Edited",@"Cancel", nil];
        
        [documentPicker showFromRect:[self getFrameForPopOver] inView:self.presentingViewController.view animated:YES];
        
    }else{
        [self showPopoverForiOS8AndAbove];
    }
    return self;
}

-(CGRect)getFrameForPopOver{
    
    CGRect sourceRect;
    
    if([self.popOverSourceButton isKindOfClass:[UIBarButtonItem class]]){
        sourceRect = [[(UIBarButtonItem*)self.popOverSourceButton valueForKey:@"view"] frame];
        
    }else if ([self.popOverSourceButton isKindOfClass:[UIButton class]]){
        sourceRect = [self.popOverSourceButton frame];
    }
    return sourceRect;
}

-(void) showPopoverForiOS8AndAbove{
    
    UIAlertController *documentPicker= [UIAlertController alertControllerWithTitle:@"Select Method" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    documentPicker.popoverPresentationController.sourceView = self.presentingViewController.view;
    documentPicker.popoverPresentationController.sourceRect = [self getFrameForPopOver];
    
    UIAlertAction *selectCameraAction = [UIAlertAction actionWithTitle:@"Camera"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action) {
                                                                   [self importFromImagePicker:self.popOverSourceButton sourceType:UIImagePickerControllerSourceTypeCamera];
                                                               }];
    
    
    UIAlertAction *selectGalleryAction = [UIAlertAction actionWithTitle:@"Gallery"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    [self importFromImagePicker:self.popOverSourceButton sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                                }];
    
    
    UIAlertAction *selectFromPreviouslyEditedImages = [UIAlertAction actionWithTitle:@"Previously Edited Images"
                                                                               style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction *action) {
                                                                                 [self showGalleryOfPreviousImages];
                                                                             }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction *action) {
                                                             [documentPicker dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    
    
    [documentPicker addAction:selectCameraAction];
    [documentPicker addAction:selectGalleryAction];
    [documentPicker addAction:selectFromPreviouslyEditedImages];
    [documentPicker addAction:cancelAction];
    
    [self.presentingViewController presentViewController:documentPicker animated:YES completion:^{
        //
    }];
}

-(void) startEditingImage:(UIImage *)image
     sourceViewController:(UIViewController *)sourceVC{
    
    self.presentingViewController = sourceVC;
    [self startEditingImage:image];
}

-(void)showGalleryOfPreviousImages{
    

    
    WDBrowserController *browser = (WDBrowserController*)
    [[UIStoryboard
                                                               storyboardWithName:@"InkPadStoryboard"
                                                               bundle:[NSBundle bundleForClass:[self class]]]
                                                              instantiateViewControllerWithIdentifier: @"WDBrowserController"];
    browser.delegate = self;
    [self.presentingViewController.navigationController pushViewController:browser animated:YES];
}

-(void)setupDefaults{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultPath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"Defaults.plist"];
    [defaults registerDefaults:[NSDictionary dictionaryWithContentsOfFile:defaultPath]];
    
    // Install valid defaults for various colors/gradients if necessary. These can't be encoded in the Defaults.plist.
    if (![defaults objectForKey:WDStrokeColorProperty]) {
        NSData *value = [NSKeyedArchiver archivedDataWithRootObject:[WDColor blackColor]];
        [defaults setObject:value forKey:WDStrokeColorProperty];
    }
    
    if (![defaults objectForKey:WDFillProperty]) {
        NSData *value = [NSKeyedArchiver archivedDataWithRootObject:[WDColor whiteColor]];
        [defaults setObject:value forKey:WDFillProperty];
    }
    
    if (![defaults objectForKey:WDFillColorProperty]) {
        NSData *value = [NSKeyedArchiver archivedDataWithRootObject:[WDColor whiteColor]];
        [defaults setObject:value forKey:WDFillColorProperty];
    }
    
    if (![defaults objectForKey:WDFillGradientProperty]) {
        NSData *value = [NSKeyedArchiver archivedDataWithRootObject:[WDGradient defaultGradient]];
        [defaults setObject:value forKey:WDFillGradientProperty];
    }
    
    if (![defaults objectForKey:WDStrokeDashPatternProperty]) {
        NSArray *dashes = @[];
        [defaults setObject:dashes forKey:WDStrokeDashPatternProperty];
    }
    
    if (![defaults objectForKey:WDShadowColorProperty]) {
        NSData *value = [NSKeyedArchiver archivedDataWithRootObject:[WDColor colorWithRed:0 green:0 blue:0 alpha:0.333f]];
        [defaults setObject:value forKey:WDShadowColorProperty];
    }
    if (![defaults objectForKey:WDFontNameProperty]){
        [defaults  setObject:@"Helvetica" forKey:WDFontNameProperty];
    }


}

#pragma mark - Camera

- (void) importFromImagePicker:(id)sender sourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.pickerController && (self.pickerController.sourceType == sourceType)) {
        [self dismissPopoverAnimated:YES];
        return;
    }
    
    [self dismissPopoverAnimated:YES];
    
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.sourceType = sourceType;
    self.pickerController.delegate = self;
    
    popoverController_ = [[UIPopoverController alloc] initWithContentViewController:self.pickerController];
    
    popoverController_.delegate = self;
    
    if([sender isKindOfClass:[UIBarButtonItem class]]){
        [popoverController_ presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    }else if ([sender isKindOfClass:[UIButton class]]){
        [popoverController_ presentPopoverFromRect:[(UIButton*)sender frame]
                                            inView:self.presentingViewController.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
}

- (void) dismissPopoverAnimated:(BOOL)animated
{
    if (popoverController_) {
        [popoverController_ dismissPopoverAnimated:animated];
        popoverController_ = nil;
    }
    self.pickerController = nil;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self imagePickerControllerDidCancel:picker];
    
    NSDateFormatter *dfm =[[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"dd-MMM-yy HH_mm"];
    self.currentFileName = [NSString stringWithFormat:@"%@",[dfm stringFromDate:[NSDate date]]];
    dfm = nil;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(drawingAdded:)
                                                 name:WDDrawingAdded
                                               object:nil];

    [[WDDrawingManager sharedInstance] createNewDrawingWithImage:info[UIImagePickerControllerOriginalImage] andName:self.currentFileName];
    dfm = nil;
    
}

- (void) drawingAdded:(NSNotification *)aNotification
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WDDrawingAdded object:nil];
    [self startEditingDocumentWithName:self.currentFileName];
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    popoverController_ = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [popoverController_ dismissPopoverAnimated:YES];
    popoverController_ = nil;
}


-(void)startEditingImage:(UIImage*)image{
    
    NSDateFormatter *dfm =[[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"dd-MMM-yy HH_mm"];
    self.currentFileName = [NSString stringWithFormat:@"%@",[dfm stringFromDate:[NSDate date]]];
    dfm = nil;
    
    if([[WDDrawingManager sharedInstance] createNewDrawingWithImage:image andName:self.currentFileName])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(drawingAdded:)
                                                     name:WDDrawingAdded
                                                   object:nil];
    }
    
}


-(void) startEditingDocumentWithName:(NSString *)name{
    

    WDCanvasController *canvasController = (WDCanvasController*)[[UIStoryboard
                                                                  storyboardWithName:@"InkPadStoryboard"
                                                                  bundle:[NSBundle bundleForClass:[self class]]]
                                                                 instantiateViewControllerWithIdentifier: @"WDCanvasController"];
    
    //[mainStoryboard instantiateViewControllerWithIdentifier: @"WDCanvasController"];

    NSString *documentFileName = [NSString stringWithFormat:@"%@.%@",name,WDDrawingFileExtension];
    canvasController.delegate = self;
    
    WDDocument *document = [[WDDrawingManager sharedInstance] openDocumentWithName:documentFileName withCompletionHandler:nil];
    [canvasController setDocument:document];
    [self.presentingViewController.navigationController pushViewController:canvasController animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self importFromImagePicker:self.popOverSourceButton sourceType:UIImagePickerControllerSourceTypeCamera];
        }break;
        case 1:{
            [self importFromImagePicker:self.popOverSourceButton sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }break;
        case 2:{
            [self showGalleryOfPreviousImages];
        }break;
            
        default:
            break;
    }
}

-(void) didSaveImageForuse:(UIImage*)image{
    NSLog(@"Image Edited and Saved");
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissMarkupSessionWithImage:imageEdited:)]){
        [self.delegate didDismissMarkupSessionWithImage:image imageEdited:YES];
    }
    [self dismissToPresentingViewController];
}

-(void) didCancelEditing:(UIImage*)image{
    NSLog(@"Image Editing Cancelled and Returned");
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissMarkupSessionWithImage:imageEdited:)]){
        [self.delegate didDismissMarkupSessionWithImage:image imageEdited:NO];
    }
    [self dismissToPresentingViewController];
}

-(void)dismissToPresentingViewController{
    UINavigationController *rootVC = (UINavigationController*)[[UIApplication sharedApplication] keyWindow].rootViewController;
    [rootVC popToViewController:self.presentingViewController animated:YES];
}


@end
