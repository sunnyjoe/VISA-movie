//
//  MBProgressHUD+ShowTextHUD.m
//
//

#import "MBProgressHUD+ShowTextHUD.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kIphoneHeightScale kScreenHeight / 667  // 667 point in iphone 6 vertical

@implementation MBProgressHUD (ShowTextHUD)

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text animated:(BOOL)animated
{
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.cornerRadius = 0;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    hud.yOffset = - 20 * kIphoneHeightScale;;
    [view addSubview:hud];
    [hud show:animated];
    [hud hide:animated afterDelay:1];
    return hud;
}

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text duration:(int)duration
{
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.userInteractionEnabled = false;
    hud.cornerRadius = 0;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    hud.yOffset = - 20 * kIphoneHeightScale;
    [view addSubview:hud];
    [hud show:true];
    hud.removeFromSuperViewOnHide = true;
    [hud hide:true afterDelay:duration];
    return hud;
}

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text duration:(int)duration oY:(float)oY
{
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.userInteractionEnabled = false;
    hud.cornerRadius = 0;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = text;
    hud.yOffset = oY;
    [view addSubview:hud];
    [hud show:true];
    hud.removeFromSuperViewOnHide = true;
    [hud hide:true afterDelay:duration];
    return hud;
}

@end
