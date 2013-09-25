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
    
    It(@"starts by telling the view to add any visible cards", ^{
      id location = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[location stub] andReturn:@[@"card", @"two"]] allCards];

      NSObject<Lesson> *lesson = [FirstLesson lessonWithCardLookup: location];
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      
      [[view expect] addCard:[OCMArg checkWithBlock:^(id obj) {
        Card *card = (Card *)obj;
        return [card.name isEqualToString:@"card"];
      }]];
 
      [[view expect] addCard:[OCMArg checkWithBlock:^(id obj) {
        Card *card = (Card *)obj;
        return [card.name isEqualToString:@"two"];
      }]];
        
      [lesson startWithView:view];
      
      [view verify];
    });
       
    It(@"adds a new card for each of the card lookups", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"list", @"of", @"names"]] allCards];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithCardLookup: lookup];
      
      [lesson startWithView:view];

      [ExpectObj(((Card *)[lesson.cards objectAtIndex:0]).name) toBe:@"list"];
      [ExpectObj(((Card *)[lesson.cards objectAtIndex:1]).name) toBe:@"of"];
      [ExpectObj(((Card *)[lesson.cards objectAtIndex:2]).name) toBe:@"names"];
    });
  
    It(@"chooses a card to guess", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0]] autorelease];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"list", @"of", @"names"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:0];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"has its minimum random card be the first one in the array", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@2]] autorelease];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"hullo"]] allCards];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:0];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"The maximum random card is the last entry in the list", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@3]] autorelease];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"hullo"]] allCards];
     
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson readFlashCard];
      
      Card *card = [lesson getCard:1];
      
      [ExpectBool(card.current) toBeTrue];
    });
    
    It(@"Can find random cards in the middle too", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@4]] autorelease];
      
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"james", @"hullo"]] allCards];
     
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
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
