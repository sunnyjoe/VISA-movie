//
//  DJFont.h
//

#import <UIKit/UIKit.h>

@interface DJFont : NSObject

+ (UIFont *)fontOfSize:(CGFloat)size;
+ (UIFont *)boldFontOfSize:(CGFloat)size;
+ (UIFont *)italicFontOfSize:(CGFloat)size;
+ (UIFont *)boldItalicFontOfSize:(CGFloat)size;

+ (UIFont *)helveticaFontOfSize:(CGFloat)size;
+ (UIFont *)boldHelveticaFontOfSize:(CGFloat)size;
+ (UIFont *)lightHelveticaFontOfSize:(CGFloat)size; 
+ (UIFont *)mediumHelveticaFontOfSize:(CGFloat)size;
+ (UIFont *)condensedHelveticaFontOfSize:(CGFloat)size;
+ (UIFont *)thinHelveticaFontOfSize:(CGFloat)size;

+ (UIFont *)contentFontOfSize:(CGFloat)size;
+ (UIFont *)contentItalicFontOfSize:(CGFloat)size;

+ (UIFont *)tutorialFont: (CGFloat)size;
@end
