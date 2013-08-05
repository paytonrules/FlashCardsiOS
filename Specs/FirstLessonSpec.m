#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "SimpleTableFactory.h"
#import "RandomNumberGenerator.h"
#import "CardInfo.h"
#import "Card.h"

@interface SimpleRandomNumberGenerator : NSObject<RandomNumberGenerator>
@property(strong) NSMutableArray *numbers;
@end

@implementation SimpleRandomNumberGenerator

-(id) initWithRandomNumbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
      self.numbers = [NSMutableArray arrayWithArray:numbers];
    }
    return self;
}

-(int) next
{
  int nextNum = [[self.numbers objectAtIndex:0] intValue];
  if (self.numbers.count > 1)
  {
    [self.numbers removeObjectAtIndex:0];
  }
  
  return nextNum;
}
@end

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by putting the visible sprites on the screen", ^{
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:
                                                            createCard(@"huzzah", 2, 4),
                                                            nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(2, 4)];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"puts ALL the visible cards on screen", ^{
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:
                                                            createCard(@"huzzah", 2, 4),
                                                            createCard(@"alsoHuzzah", 1, 3),
                                                            nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(2, 4)];
      
      [[view expect] addNewSprite:@"alsoHuzzah"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(1, 3)];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"creates a new card for each of the card structures", ^{
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", 2, 4),
                                                         nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:[OCMArg any]
                           forCard:[OCMArg checkWithBlock:^BOOL(id value) { return [value isKindOfClass:[Card class]]; }]
                        atLocation:CGPointMake(2, 4)];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    // Need an actual table lookup, and a table lookup factory.
    // Need to start the game by randomly choosing the current card see the commented test below.
    // Make sure the defaults are set
    // I want to add some motion - how about cards that aren't visible yet?
   /*
    It(@"chooses the next sprite based on the random number and the length of the list", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0, @1]];
      
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithVisibleCards:createCard(@"huzzah", 2, 4),
                                                                          createCard(@"again", 1, 1),
                                                                          nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];

      [view setExpectationOrderMatters:YES];
      [[view expect] addNewSprite:@"huzzah"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(2, 4)];

      [[view expect] addNewSprite:@"again"
                          forCard:[OCMArg any]
                       atLocation:CGPointMake(1, 1)];
      
      [lesson startWithView:view];
      [lesson addCard];
      
      [view verify];
    });*/ 
    

    
    
  });
  
}
