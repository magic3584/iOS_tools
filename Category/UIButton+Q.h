
//

#import <UIKit/UIKit.h>

@interface UIButton (Q)

+ (instancetype)buttonWithSuperview:(UIView *)superview;

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle;

+ (instancetype)buttonWithSuperview:(UIView *)superview normalImage:(NSString *)normaImage;

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle normalBackImage:(UIImage *)normalImage;

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle normalImage:(NSString *)normaImage;

@end
