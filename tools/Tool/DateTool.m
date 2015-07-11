
//

#import "DateTool.h"

@implementation DateTool

+ (NSString *)conversion:(NSString *)OriginalString format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    //所属时区，真机开发时一定要声明
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //获取到的时间
    NSDate *gotDate = [formatter dateFromString:OriginalString];
    // 获取传入时间和本地时间的差距
    NSDateComponents *component = [gotDate deltaWithNow];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //是否今年
    if ([gotDate isThisYear]) {
        //是否今天
        if ([gotDate isToday]) {
            //如果是今天
            if (component.hour >= 1) {
                //多少小时以前
                return [NSString stringWithFormat:@"%ld小时前", (long)component.hour];
            } else if (component.minute >= 1) {
                //多少分钟以前
                return [NSString stringWithFormat:@"%ld分钟前", (long)component.minute];
            } else {
                //刚刚
                return @"刚刚";
            }
        } else if ([gotDate isYesterday]){
            //是否昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:gotDate];
        } else if ([gotDate isTheDayBeforeYesterday]) {
            //是否前天
            fmt.dateFormat = @"前天 HH:mm";
            return [fmt stringFromDate:gotDate];
        } else {
            //其它天
            fmt.dateFormat = @"MM月dd日 HH:mm";
            return [fmt stringFromDate:gotDate];
        }
    } else {
        //不是今年
        fmt.dateFormat = @"yyyy年MM月dd日 HH:mm";
        return [fmt stringFromDate:gotDate];
    }
    return nil;
}

@end
