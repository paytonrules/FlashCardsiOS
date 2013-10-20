#import "FirstLesson.h"
#import "StandardRandomNumberGenerator.h"
#import "CardLookupTable.h"
#import "Card.h"

@interface FirstLesson()
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@property(strong) NSObject<GameView> *view;
@property(strong) NSMutableArray *cards;
@property(strong) Card *currentCard;
@property(strong) NSObject<CardLookup> *cardLookup;
@property(assign) BOOL started;
@end

@implementation FirstLesson

+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup
{
  return [[FirstLesson alloc] initWithCardLookup: cardLookup];
}

+(id) lessonWithCardLookup:(NSObject<CardLookup> *) cardLookup scheduler:(NSObject<Scheduler> *)scheduler
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
    self.started = NO;
  }
  return self;
}

-(void) start
{  
  for (NSString *cardName in [self.cardLookup allCards])
  {
    Card *card = [Card cardWithName: cardName lesson:self];
    
    [self.cards addObject:card];
  }
  self.started = YES;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  self.view = view;

  for (NSString *cardName in [self.cardLookup allCards])
  {
    Card *card = [Card cardWithName: cardName lesson:self];

    [self.cards addObject:card];
  }
  self.started = YES;
}

-(Card *) getCard:(NSInteger) cardNumber
{
  return (self.cards)[cardNumber];
}

-(void) update
{
  if (self.started && self.currentCard == nil)
  {
    self.currentCard = (self.cards)[[self.randomNumberGenerator next] % self.cards.count];
    [self.currentCard makeCurrent];
  }
}

-(void) correctGuess
{
  [self.view playCorrectSound];
  [self.currentCard makeUnCurrent];
  self.currentCard = nil;
}

-(void) incorrectGuess
{
  [self.view playInCorrectSound];
}

@end
