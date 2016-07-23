//
//  UIImageView + MOAdditions.m
//  

#import "UIView+Mozat.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Mozat)

-(void)addTapGestureTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    if (self.gestureRecognizers.count) {
        for (int i = 0; i < self.gestureRecognizers.count; i++) {
            UIGestureRecognizer *reg = self.gestureRecognizers[i];
            if ([reg isMemberOfClass:[UITapGestureRecognizer class]]) {
                [self removeGestureRecognizer:reg];
            }
        }
    }
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}

@end
