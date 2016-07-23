//
//  UIColor+MOAdditions.h
//  


#import <UIKit/UIKit.h>

@interface UIColor (MOAdditions)

+(UIColor *) colorFromHexString:(NSString *)hexString;
+(UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
