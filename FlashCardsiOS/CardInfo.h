#import <Foundation/Foundation.h>

@interface CardInfo : NSObject

@property(strong) NSString *spriteName;
@property(strong) NSString *reading;
@property(assign) CGPoint location;

+(CardInfo *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location;

@end