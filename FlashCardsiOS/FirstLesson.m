#import "FirstLesson.h"
#import "StandardRandomNumberGenerator.h"
#import "CardLookupTable.h"
#import "Card.h"

@interface FirstLesson()
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@property(strong) NSObject<GameView> *view;
@property(strong) NSMutableArray *cards;
@property(strong) NSObject<CardLookup> *cardLookup;
@end

@implementation FirstLesson

+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup
{
  return [[FirstLesson alloc] initWithCardLookup: cardLookup];
}

+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup andRandomNumberGenerator:(NSObject<RandomNumberGenerator>*) gen
{
  return [[FirstLesson alloc] initWithCardLookup: cardLookup andRandomNumberGenerator:gen];
}

-(id) initWithCardLookup:(NSObject<CardLookup> *) lookup
{
  return [self initWithCardLookup:lookup andRandomNumberGenerator: [StandardRandomNumberGenerator new]];
}

-(id) initWithCardLookup:(NSObject<CardLookup> *) lookup andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)gen
{
  self = [super init];
  if (self) {
    self.cardLookup = lookup;
    self.cards = [NSMutableArray new];
    self.randomNumberGenerator = gen;
  }
  return self;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  self.view = view;

  for (NSString *cardName in [self.cardLookup allCards])
  {
    Card *card = [Card cardWithName: cardName lesson:self];

    [self.cards addObject:card];
    [self.view addCard:card];
  }
}

-(Card *) getCard:(NSInteger) cardNumber
{
  return [self.cards objectAtIndex:cardNumber];
}

-(void) readFlashCard
{
  if (self.cards.count > 0) {
    Card *card = [self.cards objectAtIndex:[self.randomNumberGenerator next] % self.cards.count];
    
    [card makeCurrent];
    [self.view playClue:card];
  }
}

-(void) correctGuess
{
  [self.view playCorrectSound];
  [self readFlashCard];
}

-(void) incorrectGuess
{
  [self.view playInCorrectSound];
}

@end
