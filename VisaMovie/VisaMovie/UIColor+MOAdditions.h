//
//  UIColor+MOAdditions.h
//  DejaFashion
//
//  Created by Sun lin on 24/11/14.
//  Copyright (c) 2014 Mozat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MOAdditions)

+(UIColor *) colorFromHexString:(NSString *)hexString;
+(UIColor *) colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
