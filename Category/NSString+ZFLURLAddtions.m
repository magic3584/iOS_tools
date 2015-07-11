
//

#import "NSString+ZFLURLAddtions.h"

@implementation NSString (ZFLURLAddtions)

- (NSString *)URLEncodedFormStringUsingEncoding:(NSStringEncoding)enc{
    NSString *escapedStringWithSpaces = [self percentEscapedStringWithEncoding:enc additionalCharacters:@"&=+" ignoredCharacters:nil];
    return escapedStringWithSpaces;
}

- (NSString *)percentEscapedStringWithEncoding:(NSStringEncoding)enc additionalCharacters:(NSString *)add ignoredCharacters:(NSString *)ignore{
    
    CFStringEncoding convertedEncoding = CFStringConvertNSStringEncodingToEncoding(enc);
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)ignore, (CFStringRef)add, convertedEncoding));
}

@end
