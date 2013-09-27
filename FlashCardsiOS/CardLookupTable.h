#import <Foundation/Foundation.h>
#import "CardLookup.h"
#import "SpriteLookup.h"

@interface CardLookupTable : NSObject<CardLookup, SpriteLookup>

-(void) add:(NSDictionary *)cardData named:(NSString *) name;

@end
