//
//  DJFont.m
//  DejaFashion
//
//  Created by Kevin Lin on 18/11/14.
//  Copyright (c) 2014 Mozat. All rights reserved.
//

#import "DJFont.h"

@implementation DJFont

+(UIFont *)helveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+(UIFont *)lightHelveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:size];
}

+(UIFont *)boldHelveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+(UIFont *)mediumHelveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+(UIFont *)condensedHelveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:size];
}

+ (UIFont *)thinHelveticaFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
}

+(UIFont *)tutorialFont:(CGFloat)size {
    return [UIFont fontWithName:@"SegoePrint" size:size];
}


+ (UIFont *)fontOfSize:(CGFloat)size
{
//    return [UIFont fontWithName:@"GillSans-Light" size:size];
    return [DJFont helveticaFontOfSize:size];
}


+ (UIFont *)boldFontOfSize:(CGFloat)size
{
//    return [UIFont fontWithName:@"GillSans" size:size];
    return [DJFont boldHelveticaFontOfSize:size];
}

+ (UIFont *)italicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:size];
}

+ (UIFont *)boldItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:size];
}

+ (UIFont *)contentFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)contentItalicFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Italic" size:size];
}


@end
