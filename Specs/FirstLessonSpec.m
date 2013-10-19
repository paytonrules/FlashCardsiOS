#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"
#import "Scheduler.h"
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
  int nextNum = [(self.numbers)[0] intValue];
  if (self.numbers.count > 1)
  {
    [self.numbers removeObjectAtIndex:0];
  }
  
  return nextNum;
}
@end

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by telling the view to add any visible cards", ^{
      id location = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[location stub] andReturn:@[@"card", @"two"]] allCards];

      NSObject<Lesson> *lesson = [FirstLesson lessonWithCardLookup: location];
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      
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

      [ExpectObj(((Card *)(lesson.cards)[0]).name) toBe:@"list"];
      [ExpectObj(((Card *)(lesson.cards)[1]).name) toBe:@"of"];
      [ExpectObj(((Card *)(lesson.cards)[2]).name) toBe:@"names"];
    });
    
    It(@"displays the character introduction", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@""]] allCards];
      
      NSObject<Lesson> *lesson = [FirstLesson lessonWithCardLookup: lookup];
      
      [[view expect] showIntroduction];
      
      [lesson startWithView:view];
      
      [view verify];
    });
    
    It(@"doesnt start choosing cards until after the character introduction", ^{
      
    });
    
    It(@"only plays the character intro for a specified amount of time, or gets an event when it's complete", ^{});
  
    It(@"chooses a card to guess on update", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                            initWithRandomNumbers:@[@0]];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"list", @"of", @"names"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson update];
      
      Card *card = [lesson getCard:0];
      
      [ExpectObj(lesson.currentCard) toBe:card];
    });
    
    It(@"has its minimum random card be the first one in the array", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@2]];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"hullo"]] allCards];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson update];
      
      [ExpectBool(lesson.currentCard.current) toBeTrue];
    });
    
    It(@"The maximum random card is the last entry in the list", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@3]];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"hullo"]] allCards];
     
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson update];
      
      Card *card = [lesson getCard:1];
      
      [ExpectObj(lesson.currentCard) toBe:card];
    });
    
    It(@"Can find random cards in the middle too", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@4]];
      
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"james", @"hullo"]] allCards];
     
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      
      [lesson startWithView:view];
      [lesson update];
      
      Card *card = [lesson getCard:1];
      
      [ExpectObj(lesson.currentCard) toBe:card];
    });
    
    It(@"tells its view when there is a correct guess", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject niceMockForProtocol:@protocol(CardLookup)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup:lookup];
      
      [lesson startWithView:view];
      
      [[view expect] playCorrectSound];
      
      [lesson correctGuess];
      
      [view verify];
    });
    
    It(@"tells its view when there is an incorrect guess", ^{
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject niceMockForProtocol:@protocol(CardLookup)];
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup:lookup];
      
      [lesson startWithView:view];
      
      [[view expect] playInCorrectSound];
      
      [lesson incorrectGuess];
      
      [view verify];
    });

    It(@"Reads the clears the card on a successful guess", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@0, @1]];
     
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"you did it"]] allCards];

      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup 
                                     andRandomNumberGenerator: simpleGenerator];
      [lesson startWithView:view];
      [lesson update];

      [lesson correctGuess];
      
      [ExpectObj(lesson.currentCard) toBeNil];
    });
    
    It(@"marks the old current card as no longer current", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@0, @1]];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"you did it"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      [lesson startWithView:view];
      [lesson update];
      
      [lesson correctGuess];
      
      [ExpectBool([lesson getCard:0].current) toBeFalse];
    });
    
    It(@"creates a new current card on the next update after a correct guess", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@0, @1]];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"you did it"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      [lesson startWithView:view];
      [lesson update];
      [lesson correctGuess];
      [lesson update];
      
      [ExpectBool([lesson getCard:1].current) toBeTrue];
    });
    
    It(@"doesn't recreate a current card if there is a current card", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@0, @1]];
      
      id view = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah", @"you did it"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      [lesson startWithView:view];
      [lesson update];
      [lesson update];
      
      [ExpectBool([lesson getCard:1].current) toBeFalse];
    });
    
    It(@"doesn't create a current card if the game isn't started", ^{
      NSObject<RandomNumberGenerator> *simpleGenerator = [[SimpleRandomNumberGenerator alloc]
                                                          initWithRandomNumbers:@[@0]];
      
      id lookup = [OCMockObject mockForProtocol:@protocol(CardLookup)];
      [[[lookup stub] andReturn:@[@"huzzah"]] allCards];
      
      FirstLesson *lesson = [FirstLesson lessonWithCardLookup: lookup
                                     andRandomNumberGenerator: simpleGenerator];
      [lesson update];
      
      [ExpectObj(lesson.currentCard) toBe:nil];
    });
  });
  
}
