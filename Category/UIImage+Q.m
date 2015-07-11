
//

#import "UIImage+Q.h"

@implementation UIImage (Q)

+ (instancetype)stretchableImageName:(NSString *)name
{
    return [self stretchableImageName:name leftScale:0.5 topScale:0.5];
}

+ (instancetype)stretchableImageName:(NSString *)name leftScale:(CGFloat)leftScale topScale:(CGFloat) topScale
{
    UIImage *oldImage = [UIImage imageNamed:name];
    CGFloat left = oldImage.size.width * leftScale;
    CGFloat top = oldImage.size.height * topScale;
    return [oldImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

//图片压缩
- (instancetype)imageCompressed:(CGFloat)scale
{
    CGFloat width = self.size.width * scale;
    CGFloat height = self.size.height * scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//旋转图片
- (instancetype)imageRotatedByDegree:(CGFloat)degree
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degree * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

//裁切图片
- (instancetype)imageCircleWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.开启上下文
    CGFloat imageW = self.size.width + 2 * borderWidth;
    CGFloat imageH = self.size.height + 2 * borderWidth;
    CGFloat diameter = imageW < imageH ? imageW : imageH;
    CGSize imageSize = CGSizeMake(diameter, diameter);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 3.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = diameter * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 4.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 5.画图
    [self drawInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    
    // 6.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
