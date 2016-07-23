//
//  UIColor+MOAdditions.m
//  
//

#import "UIColor+MOAdditions.h"

@implementation UIColor (MOAdditions)


+(UIColor *) colorFromHexString:(NSString *)hexString
{
    return [self colorFromHexString:hexString alpha:1.0];
}

+(UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

@end
