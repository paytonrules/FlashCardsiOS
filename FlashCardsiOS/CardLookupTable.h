#import <Foundation/Foundation.h>
#import "CardLookup.h"
#import "SpriteLookup.h"

@interface CardLookupTable : NSObject<CardLookup, SpriteLookup>

@property(strong) NSString *spriteName;
@property(strong) NSString *reading;
@property(assign) CGPoint location;

+(CardLookupTable *) cardInfoWithName:(NSString *)name reading:(NSString *)reading atLocation:(CGPoint) location;

-(void) add:(NSDictionary *)cardData;

@end
