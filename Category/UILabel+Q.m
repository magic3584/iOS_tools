
//

#import "UILabel+Q.h"

@implementation UILabel (Q)

+ (instancetype)labelWithSuperview:(UIView *)superview text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    [superview addSubview:label];
    return label;
}

@end
