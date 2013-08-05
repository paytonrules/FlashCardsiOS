#import <UIKit/UIKit.h>
#import "CardInfo.h"
#import "SpriteTableLookupFactory.h"

@interface SimpleTableFactory : NSObject<SpriteTableLookupFactory>

+(id) factoryWithCards:(CardInfo *)card, ... NS_REQUIRES_NIL_TERMINATION;

@end