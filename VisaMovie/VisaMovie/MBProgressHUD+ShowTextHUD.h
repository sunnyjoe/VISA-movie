//
//  MBProgressHUD+ShowTextHUD.h
//  
//
 
@import MBProgressHUD;

@interface MBProgressHUD (ShowTextHUD)

+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text animated:(BOOL)animated;
+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text duration:(int)duration;
+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view text:(NSString *)text duration:(int)duration oY:(float)oY;
@end
