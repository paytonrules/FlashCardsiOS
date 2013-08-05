#import <UIKit/UIKit.h>
#import "CardInfo.h"
#import "CardLookupFactory.h"

@interface SimpleCardLookupFactory : NSObject<CardLookupFactory>

+(id) factoryWithCards:(CardInfo *)card, ... NS_REQUIRES_NIL_TERMINATION;

@end