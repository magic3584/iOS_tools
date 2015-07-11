
//

#import "Apputils.h"
#import "APPConfig.h"

@implementation Apputils

#pragma mark 调用动画特效
/*
 setType效果 (作者:somilk)
 1,kCATransitionFade 淡出
 2,kCATransitionMoveIn 覆盖原图
 3,kCATransitionPush 推出
 4,kCATransitionReveal 底部显出来
 ----------------------------------
 5,pageCurl 向上翻一页
 6,pageUnCurl 向下翻一页
 7,rippleEffect 滴水效果
 8,suckEffect 收缩效果，如一块布被抽走
 9,cube 立方体效果
 10,oglFlip 上下翻转效果
 ----------------------------------
 setSubtype方向
 1,kCATransitionFromLeft 右(默认)
 2,kCATransitionFromRight 左
 3,kCATransitionFromTop 上
 4,kCATransitionFromBottom 下
 */

+ (CATransition *)callCAT:(int)typenum fromtype:(int)fromnum TIME:(float)animation_time{
    CATransition * animation = [CATransition animation];
    [animation setDuration:animation_time];
    switch (typenum) {
        case 1: [animation setType: kCATransitionFade]; break;
        case 2: [animation setType: kCATransitionMoveIn];break;
        case 3: [animation setType: kCATransitionPush]; break;
        case 4: [animation setType: kCATransitionReveal];break;
        case 5: [animation setType: @"pageCurl"];break;
        case 6: [animation setType: @"pageUnCurl"];break;
        case 7: [animation setType: @"rippleEffect"];break;
        case 8: [animation setType: @"suckEffect"];break;
        case 9: [animation setType: @"cube"]; break;
        case 10:[animation setType: @"oglFlip"];break;
    }
    switch (fromnum) {
        case 1: [animation setSubtype: kCATransitionFromLeft];break;//方向
        case 2: [animation setSubtype: kCATransitionFromRight];break;//方向
        case 3: [animation setSubtype: kCATransitionFromTop];break;//方向
        case 4: [animation setSubtype: kCATransitionFromBottom];break;//方向
            
    }
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    return animation;
}

#pragma mark 返回时间戳 10位的时间戳
+(NSString *)getChuo_time{
    NSString *timeSp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]*1000];
    timeSp=[timeSp substringWithRange:NSMakeRange(0,10)];//NSLog(@"timeSp:%@==",timeSp); //时间戳的值
    return timeSp;
}

//通过时间字符串返回10位时间戳
+(NSString *)get_chuoTimeFromStr:(NSString *)timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:timeStr];
    NSString *timeSp = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]*1000];
    timeSp=[timeSp substringWithRange:NSMakeRange(0,10)];
    NSLog(@"timeSp:%@==",timeSp); //时间戳的值
    return timeSp;
}

#pragma mark 返回 当前时间
+ (NSString *)getNow_time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark 根据10位的时间戳 返回时间
+(NSString *)getTime_chuo_month:(long long)createTime{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}
#pragma mark 根据10位的时间戳 返回时间,间隔用/并且不带时分秒
+(NSString *)getTime_chuo_monthWithLineWithoutHour:(long long)createTime{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    return [dateFormatter stringFromDate:date];
}
#pragma mark 根据10位的时间戳 返回时间 间隔用点并且不带时分秒
+(NSString *)getTime_chuo_monthWithDotWithoutHour:(long long)createTime{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}
#pragma mark 输入一个时间戳算出与当前时间的间隔
+(NSString *)getTimeIntervalWithChuoTime:(long long)chuoTime
{
    NSDate * previousDate = [NSDate dateWithTimeIntervalSince1970:chuoTime];
    NSTimeInterval timeInterval= [[NSDate date] timeIntervalSinceDate:previousDate];
    NSString * string = nil;
    /*
     发帖时间显示规则：
     a.	发帖一分钟以内，显示具体X秒之前；
     b.	发帖一分钟以上到一小时以内，显示具体X分钟之前；
     c.	发帖一小时以上到一天以内，显示具体X小时之前；
     d.	发帖时间超过24小时以上，显示具体日期
     */
    
    int day = timeInterval / (3600 * 24);
    int hour = (timeInterval - day * 3600 * 24 ) / 3600;
    int minute = (timeInterval - day * 3600 * 24 - hour * 3600) / 60;
    int second = timeInterval - day * 3600 * 24 - hour * 3600 - minute * 60;
    if (day > 0) {//大于一天
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        string = [dateFormatter stringFromDate:previousDate];
    }else {
        if (hour > 0) {//大于一小时
            string = [NSString stringWithFormat:@"%d小时之前",hour];
        }else {
            if (minute > 0) {
                string = [NSString stringWithFormat:@"%d分钟之前",minute];
            }else {
                string = [NSString stringWithFormat:@"%d秒之前",second];
            }
            
        }
    }
    
    return  string;
}
+(BOOL)isBeingExpired:(long long)chuoTime
{
    NSDate * previousDate = [NSDate dateWithTimeIntervalSince1970:chuoTime];
    NSTimeInterval timeInterval= [[NSDate date] timeIntervalSinceDate:previousDate];

    int day = -timeInterval / (3600 * 24);

    if (day <= 3) {
        return YES;
    }else {
        return NO;
    }
    
    return YES;
}
+(BOOL)IsIos7{    //是否IOS7以上
    
    return [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0;
}

+(void)saveUserInfoDictWithDict:(NSDictionary*)aDict
{
    GlobalDataManager * m=[GlobalDataManager sharedDataManager];
    
    NSLog(@"aDict:%@",aDict);
    NSString* nickName;
    if([aDict objectForKey:@"realname"]==[NSNull null])
    {
        nickName=@"昵称";
    }
    else
    {
        nickName=[aDict objectForKey:@"realname"];
    }
    m.realname = nickName;
    
    NSString *name;
    if([aDict objectForKey:@"name"]==[NSNull null])
    {
        name = @"";
    }
    else
    {
        name = [aDict objectForKey:@"name"];
    }
    m.name = name;
    
    m.cartype = [aDict objectForKey:@"cartype"];
    m.sex = [aDict objectForKey:@"sex"];
    m.token = [aDict objectForKey:@"token"];
    
    m.qq = [aDict objectForKey:@"qq"];
    m.datetime = [NSString stringWithFormat:@"%@", [aDict objectForKey:@"datetime"]];
    m.phone = [NSString stringWithFormat:@"%@", [aDict objectForKey:@"phone"]];
    m.email = [aDict objectForKey:@"email"];
    m.m_id = [aDict objectForKey:@"m_id"];
    
    if ([aDict objectForKey:@"uid"]!=[NSNull null]) {
        m.uid =[aDict objectForKey:@"uid"];
    }
    if ([aDict objectForKey:@"id"]!=[NSNull null]) {
        m.ID =[aDict objectForKey:@"id"];
    }
    
    m.lng = [aDict objectForKey:@"lng"];//经度
    m.lat = [aDict objectForKey:@"lat"];//纬度
    m.pic = aDict[@"pic"];
    
    m.couponCount = aDict[@"couponCount"];
    // 归档数据
    [NSKeyedArchiver archiveRootObject:m toFile:UserInfoCachePath];
}


#pragma mark 手机号验证
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//是否为空字符串 比如null，(null),<null>
+(BOOL) isNullString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    NSRange rang = [string rangeOfString:@"null"];
    if (rang.location!=NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark- 读取本地文件
+(NSString *)readFile:(NSString *)fileStr{
    
    NSError *error;
    
    NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileStr ofType:@"txt"] encoding:NSUTF8StringEncoding error: & error];
    if (textFileContents == nil) {
        NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
        textFileContents =@"";
    }
    
    return textFileContents;
    
}

#pragma mark 16#转rgb
+ (UIColor *) callColorFromHexRGB:(NSString *) inColorString{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}


#pragma mark -获取文字的高度
+(CGFloat)getLabHeight:(NSString *)aText andX:(CGFloat)contentW andFont:(UIFont *)currentFont{
    
    CGRect tmpRect = [aText boundingRectWithSize:CGSizeMake(contentW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:CURRENTFONT,NSFontAttributeName, nil] context:nil];
  
    return tmpRect.size.height;
}

#pragma mark -获取订单Model
+(OrderModel *)getGrbOrderModel:(NSDictionary *)statusDict{
    
    OrderModel * model = [[OrderModel alloc]init];
    
    NSString * status = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"status"]];
    if ([Apputils isNullString:status]) {
        status = @"";
    }
    model.status = status;
    
    NSString * servicePrice = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"servicePrice"]];
    if ([Apputils isNullString:servicePrice]) {
        servicePrice = @"0";
    }
    model.servicePrice = servicePrice;
    
    NSString * extend = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"extend"]];
    if ([Apputils isNullString:extend]) {
        extend = @"";
    }
    model.extend = extend;
    
    NSString * priceStatus = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"priceStatus"]];
    if ([Apputils isNullString:priceStatus]) {
        priceStatus = @"";
    }
    model.priceStatus = priceStatus;
    
    NSString * w_comment = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"w_comment"]];
    if ([Apputils isNullString:w_comment]) {
        w_comment = @"";
    }
    model.w_comment = w_comment;
    
    NSString * u_comment = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"u_comment"]];
    if ([Apputils isNullString:u_comment]) {
        u_comment = @"";
    }
    model.u_comment = u_comment;
    
    
    NSString * content = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"content"]];
    if ([Apputils isNullString:content]) {
        content = @"";
    }
    model.content = content;
    
    NSString * addr = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"addr"]];
    if ([Apputils isNullString:addr]) {
        addr = @"";
    }
    model.addr = addr;
    
    NSString * talk = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"talk"]];
    if ([Apputils isNullString:talk]) {
        talk = @"";
    }
    model.talk = talk;
    
    NSString * total = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"total"]];
    if ([Apputils isNullString:total]) {
        total = @"0";
    }
    model.total = total;
    
    
    NSString * u_id = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"u_id"]];
    if ([Apputils isNullString:u_id]) {
        u_id = @"";
    }
    model.u_id = u_id;
    
    NSString * ID = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"id"]];
    if ([Apputils isNullString:ID]) {
        ID = @"";
    }
    model.ID = ID;
    
    NSString * cardetail = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"cardetail"]];
    if ([Apputils isNullString:cardetail]) {
        cardetail = @"";
    }
    model.cardetail = cardetail;
    
    
    NSString * num = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"num"]];
    if ([Apputils isNullString:num]) {
        num = @"";
    }
    model.num = num;
    
    NSString * w_end = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"w_end"]];
    if ([Apputils isNullString:w_end]) {
        w_end = @"";
    }
    model.w_end = w_end;
    
    NSString * u_end = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"u_end"]];
    if ([Apputils isNullString:u_end]) {
        u_end = @"";
    }
    model.u_end = u_end;
    
    NSString * w_id = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"w_id"]];
    if ([Apputils isNullString:w_id]) {
        u_end = @"";
    }
    model.w_id = w_id;
    
    
    NSString * apointtime = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"apointtime"]];
    if ([Apputils isNullString:apointtime]) {
        apointtime = @"";
    }
    model.apointtime = apointtime;
    
    NSString * u_del = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"u_del"]];
    if ([Apputils isNullString:u_del]) {
        u_del = @"";
    }
    model.u_del = u_del;
    
    NSString * w_del = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"w_del"]];
    if ([Apputils isNullString:w_del]) {
        w_del = @"";
    }
    model.w_del = w_del;
    
    NSArray *pics = [statusDict objectForKey:@"pic"];
    if (pics) {
        model.pic = [pics copy];
    }
    
    
    NSString * datetime = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"datetime"]];
    if ([Apputils isNullString:datetime]) {
        datetime = @"";
    }
    model.datetime = datetime;
    
    NSString * w_status = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"w_status"]];
    if ([Apputils isNullString:w_status]) {
        w_status = @"";
    }
    model.w_status = w_status;
    
    NSString * u_status = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"u_status"]];
    if ([Apputils isNullString:u_status]) {
        u_status = @"";
    }
    model.u_status = u_status;
    
    NSString * pausetime = [NSString stringWithFormat:@"%@",[statusDict objectForKey:@"pausetime"]];
    if ([Apputils isNullString:pausetime]) {
        pausetime = @"";
    }
    model.pausetime = pausetime;
    
    NSDictionary *user = [statusDict objectForKey:@"user"];
    if (user) {
        model.user = [user copy];
    }
    
    NSDictionary *wuser;
    if ([[statusDict objectForKey:@"wuser"] isKindOfClass:[NSDictionary class]]) {
        wuser = [statusDict objectForKey:@"wuser"];
        if (wuser) {
            model.wuser = [wuser copy];
        }
    }
    
    NSDictionary *carprice = [statusDict objectForKey:@"carprice"];
    if (carprice) {
        model.carprice = [carprice copy];
    }
    
    NSString *orderType = [statusDict objectForKey:@"orderType"];
    if (orderType) {
        model.orderType = [orderType copy];
    }
    
    NSString *serviceId = [statusDict objectForKey:@"serviceId"];
    if (serviceId) {
        model.serviceId = [serviceId copy];
    }
    
    return  model;
    
}

+(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    NSLog(@"执行图片下载函数");
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}

#pragma mark 邮箱验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 @method 获取指定宽度情况下，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UIFont *font = [UIFont fontWithName:FontBold size:fontSize];
    CGSize size = CGSizeMake(width,CGFLOAT_MAX);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    
    if ([self IsIos7]){//IOS 7.0 以上
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[value boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }else
        size = [value sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    float temphig=size.height/fontSize+8;//NSLog(@"temp=%f,s=%f,s=%f",temphig,size.height,size.height/fontSize);
    return size.height+temphig;
}
/**
 @method 获取字符串value的    宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @result float 返回的宽度
 */
+(float) WidthForString:(NSString *)value fontSize:(float)fontSize{
    UIFont *font = [UIFont fontWithName:FontBold size:fontSize];
    CGSize size = CGSizeMake(MAXFLOAT,CGFLOAT_MAX);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    
    if ([self IsIos7]){//IOS 7.0 以上
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[value boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }else
        size = [value sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    return size.width+10;
}

+ (NSString *)getDatetime:(NSString *)timeStr
{
    
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [DateTool conversion:[formatter stringFromDate:oldDate] format:@"yyyy-MM-dd HH:mm"];
    
}

@end
