#import <Foundation/Foundation.h>

@protocol SpriteLookup <NSObject>

-(NSString *) spriteByName:(NSString *)name;
-(NSString *) readingByName:(NSString *)name;
-(CGPoint) locationByName:(NSString *)name;
@end
