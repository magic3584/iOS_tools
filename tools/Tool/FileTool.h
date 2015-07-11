
//

#import <Foundation/Foundation.h>

@interface FileTool : NSObject

/**
 *  根据文件或文件夹路径计算文件大小
 *
 *  @param path 文件或文件夹路径
 *
 *  @return xx（单位：bite）
 */
+ (int)fileToolSizeAtFilePath:(NSString *)path;
/**
 *  删除文件夹中的所有文件
 *
 *  @param path 文件夹路径
 */
+ (void)fileToolDeleteWithFilePath:(NSString *)path;

@end
