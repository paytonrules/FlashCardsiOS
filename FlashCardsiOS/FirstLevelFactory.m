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
      self.simpleFactory = [SimpleCardLookupFactory factoryWithCards:
                            [CardInfo cardInfoWithName:@"Enemy Bug.png" reading:@"bug.mp3" atLocation:CGPointMake(100, 200)],
                            [CardInfo cardInfoWithName:@"Star.png" reading:@"star.mp3" atLocation:CGPointMake(300, 400)],
                            [CardInfo cardInfoWithName:@"Tree Tall.png" reading:@"tree.mp3" atLocation:CGPointMake(500, 400)],
                            nil];
    }
    return self;
}

-(NSArray *) create
{
  return [self.simpleFactory create];
}

@end
