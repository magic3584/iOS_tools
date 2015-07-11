
//

#import <UIKit/UIKit.h>

@interface UIImage (Q)

/**
 *  拉伸放大图片 默认取中心点
 */
+ (instancetype)stretchableImageName:(NSString *)name;
/**
 *  拉伸放大图片 自由比例
 */
+ (instancetype)stretchableImageName:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat)rightScale;
/**
 *  图片压缩
 */
- (instancetype)imageCompressed:(CGFloat)scale;
/**
 *  旋转图片
 *
 *  @param degree 旋转的角度
 *  @return 旋转后的图片
 */
- (instancetype)imageRotatedByDegree:(CGFloat)degree;
/**
 *  裁切圆形图片
 *
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *
 *  @return 裁切后的图片
 */
- (instancetype)imageCircleWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
