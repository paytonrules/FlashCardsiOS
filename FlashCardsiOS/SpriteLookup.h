#import <Foundation/Foundation.h>

@protocol SpriteLookup <NSObject>

-(NSString *) spriteByName:(NSString *)name;
-(NSString *) readingByName:(NSString *)name;
@end
