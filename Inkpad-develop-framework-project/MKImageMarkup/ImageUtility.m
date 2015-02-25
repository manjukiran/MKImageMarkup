//
//  ImageUtility.m
//  Inkpad
//
//  Created by Manju Kiran on 25/02/2015.
//  Copyright (c) 2015 Taptrix, Inc. All rights reserved.
//

#import "ImageUtility.h"

@implementation ImageUtility

+(UIImage*) imageNamed:(NSString*)imageName{
    NSString* path = [NSString stringWithFormat:@"%@/%@", [[NSBundle bundleForClass:[self class]] resourcePath],imageName];
    return [[UIImage alloc]initWithContentsOfFile:path];
}
@end
