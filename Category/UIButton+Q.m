
//

#import "UIButton+Q.h"

@implementation UIButton (Q)

+ (instancetype)buttonWithSuperview:(UIView *)superview
{
    UIButton *btn = [[UIButton alloc] init];
    [superview addSubview:btn];
    return btn;
}

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [superview addSubview:btn];
    return btn;
}

+ (instancetype)buttonWithSuperview:(UIView *)superview normalImage:(NSString *)normaImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:normaImage] forState:UIControlStateNormal];
    [superview addSubview:btn];
    return btn;
}

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle normalBackImage:(UIImage *)normalImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [superview addSubview:btn];
    return btn;
}

+ (instancetype)buttonWithSuperview:(UIView *)superview normalTitle:(NSString *)normalTitle normalImage:(NSString *)normaImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:normaImage] forState:UIControlStateNormal];
    [superview addSubview:btn];
    return btn;
}

@end
