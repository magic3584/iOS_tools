
//

#import <Foundation/Foundation.h>

@interface NSString (ZFLURLAddtions)
- (NSString *)URLEncodedFormStringUsingEncoding:(NSStringEncoding)enc;
- (NSString *)percentEscapedStringWithEncoding:(NSStringEncoding)enc additionalCharacters:(NSString *)add ignoredCharacters:(NSString *)ignore;
@end
