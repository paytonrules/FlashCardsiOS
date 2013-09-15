#import <UIKit/UIKit.h>
#import "CardLookupTable.h"
#import "CardLookupFactory.h"

@interface SimpleCardLookupFactory : NSObject<CardLookupFactory>

+(id) factoryWithCards:(CardLookupTable *)card, ... NS_REQUIRES_NIL_TERMINATION;

@end