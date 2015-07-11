

// 自定义Log宏，在release模式运行时，取消所有的日志输出
#ifdef DEBUG
#define GKLog(...)                 NSLog(__VA_ARGS__)
#else
#define GKLog(...)
#endif

// Log字典或数组，并Log是哪个类调用的哪个函数
#define LogObject(obj)            GKLog(@"%s  %@", __func__, obj);
// Log指定视图的frame
#define LogFrame(view)            GKLog(@"%@", NSStringFromCGRect(view.frame));
// Log指定视图中的所有子视图
#define LogSubViews(view)         GKLog(@"%@", view.subviews);


// 判断系统的版本
#define iOS7_below                ([UIDevice currentDevice].systemVersion.floatValue < 7.0)
#define iOS7_beyond               ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define iOS8                      ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
// 角度转弧度
#define DegreeToAngle(degree)     (((degree) * M_PI) / 180.0)
// 弧度转角度
#define AngleToDegree(angle)      (((angle) * 180.0) / M_PI)
// 屏幕分辨率
#define ScreenScale               ([UIScreen mainScreen].scale)
// 4英寸屏幕
#define Is4inch                   ([UIScreen mainScreen].bounds.size.height == 568.0)
// 3.5英寸屏幕
#define Is3inch                   ([UIScreen mainScreen].bounds.size.height == 480.0)
// 屏幕宽度
#define ScreenWidth               ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define ScreenHeight              ([UIScreen mainScreen].bounds.size.height)
// RGB颜色
#define ColorWithRGB(R,G,B,a)     [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:a]
// 16进制色值转颜色
#define HexRGBAlpha(rgbValue,a)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

// 系统普通字体
#define SystemFont(size)          [UIFont systemFontOfSize:size]
// 系统加粗字体
#define BoldSystemFont(size)      [UIFont boldSystemFontOfSize:size]
// 无限大的尺寸
#define InfinitySize              CGSizeMake(MAXFLOAT, MAXFLOAT)
// tabBar的高度
#define TabBarHeight              (49.0)
// navBar的高度
#define NavBarHeight              (64.0)
// 快速返回UIImage对象
#define Image(imageName)          [UIImage imageNamed:imageName]
// 透明颜色
#define ClearColor                [UIColor clearColor]
// 黑色
#define BlackColor                [UIColor blackColor]
// 白色
#define WhiteColor                [UIColor whiteColor]
// 红色
#define RedColor                  [UIColor redColor]
// 灰色
#define GrayColor                 [UIColor grayColor]
// 浅灰色
#define LightGrayColor            [UIColor lightGrayColor]
//可点击的红色
#define TouchEnableColor           HexRGBAlpha(0xff5656, 1)
//不可点击的灰色
#define TouchDisableColor          HexRGBAlpha(0xd1d1d1, 1)
///自定义的背景灰色
#define MyDesignGray HexRGBAlpha(0xededed, 1)

///分割线的颜色
#define kLineColor HexRGBAlpha(0xcccccc, 1)

//购物车界面圆按钮的宽
#define kBlanketCircleWidth 20

#import "UILabel+Q.h"
#import "UIButton+Q.h"
#import "UIImageView+Q.h"
#import "UIView+Q.h"
#import "NSString+Q.h"
#import "NSString+MD5.h"
#import "UIImage+Q.h"
#import "NSDate+Judge.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

