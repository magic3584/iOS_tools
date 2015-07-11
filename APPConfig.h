
//

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define IS_3_5INCH   ([[UIScreen mainScreen]bounds].size.height == 480)



#define PATH_OF_DOCUMENT            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
