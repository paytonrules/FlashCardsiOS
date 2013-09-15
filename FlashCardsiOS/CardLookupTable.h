#import <Foundation/Foundation.h>

@interface CardLookupTable : NSObject<LocationLookup, SpriteLookup>

@property(strong) NSString *spriteName;
@property(strong) NSString *reading;
@property(assign) CGPoint location;

+(CardLookupTable *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location;

@end