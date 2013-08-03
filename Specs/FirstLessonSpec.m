#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "TableFactory.h"
#import "RandomNumberGenerator.h"
#import "CardInfo.h"

@interface SimpleTableFactory : NSObject<TableFactory>
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

-(float) next
{
  return 0.0;
}
@end

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by creating a sprite from a card", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [SimpleRandomNumberGenerator new];
      NSObject<TableFactory> *tableFactory = [SimpleTableFactory new];
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      CGPoint location = CGPointMake(0, 0);
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];
      
      
      
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:location];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
  });
  
}
