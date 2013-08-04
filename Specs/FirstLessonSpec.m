#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "SpriteTableLookupFactory.h"
#import "RandomNumberGenerator.h"
#import "CardInfo.h"

@interface SimpleTableFactory : NSObject<SpriteTableLookupFactory>
@end

@implementation SimpleTableFactory

-(NSArray *) create
{
  CardInfo info;
  info.spriteName = @"huzzah";
  info.location = CGPointMake(2, 4);
  return @[[NSValue valueWithBytes:&info objCType:@encode(CardInfo)]];
}

@end

@interface SimpleRandomNumberGenerator : NSObject<RandomNumberGenerator>
@end

@implementation SimpleRandomNumberGenerator

-(int) next
{
  return 0;
}
@end

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by creating a sprite from a card", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [SimpleRandomNumberGenerator new];
      NSObject<SpriteTableLookupFactory> *tableFactory = [SimpleTableFactory new];
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      CGPoint location = CGPointMake(2, 4);
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];
      
      
      
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:location];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    // Need an actual random number generator
    // Need a table lookup
    // Need to make the first lesson use those
    // Need to cycle on success (ergo state machine)
    
    
  });
  
}
