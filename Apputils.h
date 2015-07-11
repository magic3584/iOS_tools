
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
#import "DateTool.h"

@interface Apputils : NSObject

/*调用动画*/
+ (CATransition *)callCAT:(int)typenum fromtype:(int)fromnum TIME:(float)animation_time;
///// 返回 当前时间
+(NSString *)getNow_time;
///// 判断是不是空字符串
+(BOOL) isNullString:(NSString *)string;
/*颜色:得到16#转rgb*/
+ (UIColor *) callColorFromHexRGB:(NSString *) inColorString;
+(BOOL)IsIos7;//ios 8 以上
+ (BOOL) isValidateMobile:(NSString *)mobile; //是不是手机号
+ (BOOL)isValidateEmail:(NSString *)email;  //是不是邮箱
// 返回时间戳
+(NSString *)getChuo_time;

/**根据10位的时间戳 返回时间 */
+(NSString *)getTime_chuo_month:(long long)createTime;

///根据10位的时间戳 返回时间,间隔用/并且不带时分秒
+(NSString *)getTime_chuo_monthWithLineWithoutHour:(long long)createTime;

///根据10位的时间戳 返回时间 间隔用点并且不带时分秒
+(NSString *)getTime_chuo_monthWithDotWithoutHour:(long long)createTime;

//通过时间字符串返回时间戳
+(NSString *)get_chuoTimeFromStr:(NSString *)timeStr;

///输入一个时间戳算出与当前时间的间隔
+(NSString *)getTimeIntervalWithChuoTime:(long long)chuoTime;

///3天以内就算快过期
+ (BOOL)isBeingExpired:(long long)chuoTime;

/** 保存用户信息  */
+(void)saveUserInfoDictWithDict:(NSDictionary*)aDict;

/** 计算文字高度 */
+(CGFloat)getLabHeight:(NSString *)aText andX:(CGFloat)contentW andFont:(UIFont *)currentFont;
 
/** 获取订单Model  **/
+(OrderModel *)getGrbOrderModel:(NSDictionary *)statusDict;

/** 读取本地文件 **/
+(NSString *)readFile:(NSString *)fileStr;

+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(float) WidthForString:(NSString *)value fontSize:(float)fontSize;

/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;

+(UIImage *) getImageFromURL:(NSString *)fileURL;

+ (NSString *)getDatetime:(NSString *)timeStr;


@end
