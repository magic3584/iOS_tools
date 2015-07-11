
//

#import "FileTool.h"

@implementation FileTool

+ (int)fileToolSizeAtFilePath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    //判断路径是否合法
    BOOL dir = NO;
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&dir];
    if (!exist) {
        return 0;
    }
    
    int totalSize = 0;
    //如果是文件夹
    if (dir) {
        //获取文件夹下所有文件和文件夹的子路径
        NSArray *subPaths = [manager subpathsAtPath:path];
        for (NSString *subPath in subPaths) {
            NSString *fullPath = [path stringByAppendingPathComponent:subPath];
            //判断是否是文件夹
            BOOL dir = NO;
            [manager fileExistsAtPath:fullPath isDirectory:&dir];
            if (!dir) {
                NSDictionary *dict = [manager attributesOfItemAtPath:fullPath error:nil];
                totalSize += [dict[NSFileSize] intValue];
            }
        }
    } else {
        NSDictionary *dict = [manager attributesOfItemAtPath:path error:nil];
        return [dict[NSFileSize] intValue];
    }
    return totalSize;
}

+ (void)fileToolDeleteWithFilePath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    // 判断路径是否合法
    BOOL dir = NO;
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&dir];
    if (!exist) {
        NSLog(@"path:%@ 路径不合法", path);
        return;
    }
    // 如果是文件夹
    if (dir) {
        NSArray *subPaths = [manager subpathsAtPath:path];
        for (NSString *subPath in subPaths) {
            NSString *fullPath = [path stringByAppendingPathComponent:subPath];
            [manager removeItemAtPath:fullPath error:nil];
        }
    } else {
        [manager removeItemAtPath:path error:nil];
    }
}

@end
