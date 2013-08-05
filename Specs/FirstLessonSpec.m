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
    
    It(@"randomly chooses a card to guess", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0]];
      
      NSObject<SpriteTableLookupFactory> *tableFactory =[SimpleTableFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", 2, 4),
                                                         nil];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:0];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    // Need to start the game by randomly choosing the current card see the commented test below.
    // Make sure the defaults are set to the first level and the real random number generator


    
    
  });
  
}
