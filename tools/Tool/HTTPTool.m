
//  网络请求的工作队列指定在AppDelegate中声明的队列中

#import "HTTPTool.h"
#import "AFNetworking.h"
#import "ImageInfo.h"

@interface HTTPTool ()

@property (nonatomic, assign) NSInteger step;
@property (nonatomic, assign) BOOL fail;

@end

@implementation HTTPTool

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.operationQueue = APP.requestQueue;
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [MBProgressHUD hideHUD];
        if (error && error.code != -999) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.operationQueue = APP.requestQueue;
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [MBProgressHUD hideHUD];
        if (error && error.code != -999) {
            failure(error);
        }
    }];
    
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters imageInfo:(ImageInfo *)imageInfo success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.operationQueue = APP.requestQueue;
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将图片转换为二进制
        NSData *data = UIImageJPEGRepresentation(imageInfo.image, 0.5);
        // 上传文件
        [formData appendPartWithFileData:data name:imageInfo.key fileName:imageInfo.imageName mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [MBProgressHUD hideHUD];
        if (error && error.code != -999) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters images:(NSArray *)images success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.operationQueue = APP.requestQueue;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (ImageInfo *imageInfo in images) {
            // 将图片转换为二进制
            NSData *data = UIImageJPEGRepresentation(imageInfo.image, 0.5);
            // 上传文件
            [formData appendPartWithFileData:data name:imageInfo.key fileName:imageInfo.imageName mimeType:@"image/png"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error && error.code != -999) {
            failure(error);
        }
    }];
}


@end
