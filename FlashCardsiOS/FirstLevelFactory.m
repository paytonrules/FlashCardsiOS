#import "SimpleCardLookupFactory.h"
#import "FirstLevelFactory.h"
#import "CardInfo.h"

@interface FirstLevelFactory()

@property(strong) SimpleCardLookupFactory* simpleFactory;

@end

@implementation FirstLevelFactory

- (id)init
{
    self = [super init];
    if (self) {
      self.simpleFactory = [SimpleCardLookupFactory factoryWithCards:createCard(@"Enemy Bug.png", 100, 200),
       createCard(@"Star.png", 300, 400),
       createCard(@"Tree Tall.png", 500, 400),
       nil];
    }
    return self;
}
-(NSArray *) create
{
  return [self.simpleFactory create];
}

@end
