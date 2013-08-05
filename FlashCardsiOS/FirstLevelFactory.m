#import "SimpleTableFactory.h"
#import "FirstLevelFactory.h"
#import "CardInfo.h"

@interface FirstLevelFactory()

@property(strong) SimpleTableFactory* simpleFactory;

@end

@implementation FirstLevelFactory

- (id)init
{
    self = [super init];
    if (self) {
      self.simpleFactory = [SimpleTableFactory factoryWithCards:createCard(@"Enemy Bug.png", 100, 200),
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
