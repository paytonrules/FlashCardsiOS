#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "SimpleCardLookupFactory.h"
#import "RandomNumberGenerator.h"
#import "CardLookupTable.h"
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

CardLookupTable *createCard(NSString *name, NSString *reading, int x, int y)
{
  return [CardLookupTable cardInfoWithName:name reading:reading atLocation:CGPointMake(x, y)];
}

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by putting the visible sprites on the screen", ^{
      CardLookupTable *cardInfo = [CardLookupTable cardInfoWithName:@"huzzah"
                                            reading:@""
                                         atLocation:CGPointMake(2,4)];
      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                            cardInfo,
                                                            nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:cardInfo
                          forCard:[OCMArg any]];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"puts ALL the visible cards on screen", ^{
      CardLookupTable *firstCard = createCard(@"huzzah", @"", 2, 4);
      CardLookupTable *secondCard = createCard(@"alsoHuzzah", @"", 1, 3);
      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                            firstCard,
                                                            secondCard,
                                                            nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:firstCard forCard:[OCMArg any]];
      
      [[view expect] addNewSprite:secondCard
                          forCard:[OCMArg any]];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"creates a new card for each of the card structures", ^{
      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", @"", 2, 4),
                                                         nil];
      
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory];
      
      [[view expect] addNewSprite:[OCMArg any]
                           forCard:[OCMArg checkWithBlock:^BOOL(id value) {
        return [value isKindOfClass:[Card class]] && ((Card*) value).lesson == lesson;
      }]];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"chooses a card to guess", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0]] autorelease];

      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", @"", 2, 4),
                                                         nil];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                                  andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:0];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"has its minimum random card be the first one in the array", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@2]] autorelease];
      
      NSObject<CardLookupFactory> *tableFactory = [SimpleCardLookupFactory factoryWithCards:
                                                         createCard(@"huzzah", @"", 2, 4),
                                                         createCard(@"hullo", @"", 1, 3),
                                                         nil];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                             andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:0];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"The maximum random card is the last entry in the list", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@3]] autorelease];
      
      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", @"", 2, 4),
                                                         createCard(@"hullo", @"", 1, 3),
                                                         nil];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                             andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:1];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"Can find random cards in the middle too", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@4]] autorelease];
      
      NSObject<CardLookupFactory> *tableFactory =[SimpleCardLookupFactory
                                                         factoryWithCards:
                                                         createCard(@"huzzah", @"", 2, 4),
                                                         createCard(@"james", @"", 2, 4),
                                                         createCard(@"hullo", @"", 1, 3),
                                                         nil];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithSpriteTableFactory: tableFactory
                                             andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:1];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"tells its view when there is a correct guess", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [[FirstLesson new] autorelease];
      
      [lesson startWithView:view];
      
      [[view expect] playCorrectSound];
      
      [lesson correctGuess];
      
      [view verify];
    });
    
    It(@"tells its view when there is an incorrect guess", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [[FirstLesson new] autorelease];
      
      [lesson startWithView:view];
      
      [[view expect] playInCorrectSound];
      
      [lesson incorrectGuess];
      
      [view verify];
    });
    
    // Plays the sound when the new card is chosen
    // Need to start the game by randomly choosing a card
    // Make sure the defaults are set to the first level and the real random number generator
    // Begin tweaking the game.
  });
  
}
