
//  依赖于NSDate+judge分类

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
/**
 *  转换日期格式
 *
 *  @param string 原始时间字符串
 *
 *  @return 格式化完成的字符串
 */
+ (NSString *)conversion:(NSString *)OriginalString  format:(NSString *)format;

@end
