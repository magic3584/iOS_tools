
//  依赖于AFN框架

#import <Foundation/Foundation.h>
@class ImageInfo;

@interface HTTPTool : NSObject

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/** 上传图片 */
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters imageInfo:(ImageInfo *)imageInfo success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/** 上传多张图片 */
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters images:(NSArray *)images success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
