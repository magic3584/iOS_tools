
//

#import "NSString+Q.h"

@implementation NSString (Q)

- (NSString *)URLString
{
    NSString *URLValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
    return URLValue;
}

- (NSString *)securityPhoneNumber
{
    if (self.length != 11) {
        return nil;
    }
    NSString *securite = @"****";
    NSString *prefix = [self substringToIndex:3];
    NSString *suffix = [self substringFromIndex:7];
    return [NSString stringWithFormat:@"%@%@%@", prefix, securite, suffix];
}

- (BOOL)isNull
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self rangeOfString:@"null"].length) {
        return YES;
    }
    if ([self rangeOfString:@"(null)"].length) {
        return YES;
    }
    if ([self rangeOfString:@"<null>"].length) {
        return YES;
    }
    return NO;
}

- (BOOL)phoneNumberFormJudge
{
    NSString *phoneRegex = @"^[1][34578][0-9]{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

- (BOOL)identityCardNumberFormJudge
{
    if (self.length == 15 ||
        self.length == 18) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)emailFormJudge
{
    if (![self rangeOfString:@"@"].length ||
        ![self rangeOfString:@"."].length ||
        ![self rangeOfString:@"@"].location ||
        [self rangeOfString:@"."].location == self.length - 1 ||
        [self rangeOfString:@"."].location < [self rangeOfString:@"@"].location ||
        [self rangeOfString:@"."].location - [self rangeOfString:@"@"].location == 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)carLicenseTagJudge
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}

- (CGSize)stringSize:(UIFont *)font maxSize:(CGSize)maxSize
{
    CGSize size = CGSizeZero;
    if (iOS7_beyond) {
        CGRect textRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        size = textRect.size;
    } else {
        size = [self sizeWithFont:font constrainedToSize:maxSize];
    }
    return size;
}
- (CGSize)stringSize:(UIFont *)font
{
    return [self stringSize:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

/** 查找字符串中第一个匹配项 */
- (NSString *)firstMatchWithPattern:(NSString *)pattern
{
    // 1. 实例化正则
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:pattern
                                  options:NSRegularExpressionCaseInsensitive
                                  | NSRegularExpressionDotMatchesLineSeparators
                                  error:&error];
    if (error) {
        NSLog(@"匹配模式不正确");
        return nil;
    }
    // 2. 匹配一项内容
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:self
                                                         options:NSMatchingReportCompletion
                                                           range:NSMakeRange(0, self.length)];
    if (firstMatch) {
        // 返回第一个分组中内容
        NSRange range = [firstMatch rangeAtIndex:1];
        return [self substringWithRange:range];
    } else {
        NSLog(@"没有找到匹配内容");
    }
    return nil;
}

/** 查找字符串中所有匹配项 */
- (NSArray *)matchsWithPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:&error];
    if (error) {
        NSLog(@"匹配模式不正确");
        return nil;
    }
    // 匹配所有内容
    NSArray *array = [regex matchesInString:self
                                    options:NSMatchingReportCompletion
                                      range:NSMakeRange(0, self.length)];
    if (array == nil) {
        NSLog(@"没有找到匹配内容");
    }
    return array;
}

/** 截断首尾空白字符 */
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)appendCachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:self];
}

- (NSString *)appendTmpDirPath
{
    NSString *path = NSTemporaryDirectory();
    
    return [path stringByAppendingPathComponent:self];
}

- (NSString *)appendDocumentPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [path stringByAppendingPathComponent:self];
}

// 当前日期时间字符串
+ (NSString *)currentDateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [formatter stringFromDate:[NSDate date]];
}
// base64编码
- (NSString *)base64Encode
{
    // 1. 将字符串转换成二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // 返回base64编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}
// base64解码
- (NSString *)base64Decode
{
    // 1. 使用base64编码的字符串创建二进制数据
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    // 2. 返回base64解码后的字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
