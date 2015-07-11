
//

#import <Foundation/Foundation.h>

@interface NSString (Q)

/** URL转码 */
@property (nonatomic, readonly) NSString *URLString;
/** 手机号隐藏中间4位 */
@property (nonatomic, readonly) NSString *securityPhoneNumber;
/** base64编码 */
@property (nonatomic, readonly) NSString *base64Encode;
/** base64解码 */
@property (nonatomic, readonly) NSString *base64Decode;
/** 截断首尾空白字符 */
@property (nonatomic, readonly) NSString *trimString;

/** 当前日期时间字符串 */
+ (NSString *)currentDateTime;

/** 字符串是否为空判断 */
- (BOOL)isNull;

/** 手机号码格式判断 */
- (BOOL)phoneNumberFormJudge;

/** 身份证码格式判断 */
- (BOOL)identityCardNumberFormJudge;

/** 邮箱格式判断 */
- (BOOL)emailFormJudge;

/** 车牌号格式判断 */
- (BOOL)carLicenseTagJudge;

/** 追加缓存路径 */
- (NSString *)appendCachePath;
/** 追加临时路径 */
- (NSString *)appendTmpDirPath;
/** 追加文档路径 */
- (NSString *)appendDocumentPath;

/**
 *  获取字符串占用的尺寸
 *  @param font    字符串字体大小
 *  @param maxSize 最大占用尺寸
 *  @return 字符串实际占用尺寸
 */
- (CGSize)stringSize:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  获取字符串占用的尺寸（不限制占用尺寸）
 *  @param font    字符串字体大小
 *  @return 字符串实际占用尺寸
 */
- (CGSize)stringSize:(UIFont *)font;

/**
 *  查找字符串中第一个匹配项
 *
 *  @param pattern 匹配方案
 *  @return 第一个匹配字符串
 */
- (NSString *)firstMatchWithPattern:(NSString *)pattern;

/**
 *  查找字符串中所有匹配项
 *
 *  @param pattern 匹配方案
 *  @return 匹配数组（NSTextCheckingResult）
 */
- (NSArray *)matchsWithPattern:(NSString *)pattern;

@end
