
//

#import <UIKit/UIKit.h>

@interface UIView (Q)

+ (instancetype)viewWithSuperview:(UIView *)superView backgroundColor:(UIColor *)backgroundColor;

- (void)viewRotatedByDegree:(CGFloat)degree;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
