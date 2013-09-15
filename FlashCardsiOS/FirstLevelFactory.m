#import "SimpleCardLookupFactory.h"
#import "FirstLevelFactory.h"
#import "CardLookupTable.h"

@interface FirstLevelFactory()

@property(strong) SimpleCardLookupFactory* simpleFactory;

@end

@implementation FirstLevelFactory

- (id)init
{
    self = [super init];
    if (self) {
      self.simpleFactory = [SimpleCardLookupFactory factoryWithCards:
                            [CardLookupTable cardInfoWithName:@"Enemy Bug.png" reading:@"bug.mp3" atLocation:CGPointMake(200, 400)],
                            [CardLookupTable cardInfoWithName:@"Star.png" reading:@"star.mp3" atLocation:CGPointMake(700, 400)],
                            [CardLookupTable cardInfoWithName:@"Tree Tall.png" reading:@"tree.mp3" atLocation:CGPointMake(450, 600)],
                            nil];
    }
    return self;
}

-(NSArray *) create
{
  return [self.simpleFactory create];
}

@end
