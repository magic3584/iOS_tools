
//

#import "UIImageView+Q.h"

@implementation UIImageView (Q)

+ (instancetype)imageViewWithSuperview:(UIView *)superView image:(UIImage *)aImage
{
    UIImageView *aImageView = [[UIImageView alloc] init];
    aImageView.image = aImage;
    [superView addSubview:aImageView];
    return aImageView;
}

@end
