#import "FirstLesson.h"
#import "StandardRandomNumberGenerator.h"
#import "FirstLevelFactory.h"
#import "CardLookupTable.h"
#import "Card.h"

@interface FirstLesson()
@property(strong) NSArray *cardData;
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@property(strong) NSObject<GameView> *view;
@property(strong) NSMutableArray *cards;
@end

@implementation FirstLesson

-(id) init
{
  return [self initWithCardInfoFactory:[[FirstLevelFactory new] autorelease]
              andRandomNumberGenerator:[[StandardRandomNumberGenerator new] autorelease]];
}

-(id) initWithCardInfoFactory:(NSObject<CardLookupFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *) generator
{
  self = [super init];
  if (self) {
    self.cards = [NSMutableArray new];
    self.cardData = [[factory create] autorelease];
    self.randomNumberGenerator = generator;
  }
  return self;
}

+(id) lessonWithSpriteTableFactory:(NSObject<CardLookupFactory> *)tableFactory
{
  return [self lessonWithSpriteTableFactory:tableFactory
                   andRandomNumberGenerator:nil];
}

+(id) lessonWithSpriteTableFactory:(NSObject<CardLookupFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)generator
{
  return[[[FirstLesson alloc] initWithCardInfoFactory:factory
                             andRandomNumberGenerator:generator] autorelease];
}

-(void) startWithView:(NSObject<GameView> *)view
{
  self.view = view;
  
  for (CardLookupTable *cardInfo in self.cardData)
  {
    Card *card = [[Card cardWithLesson:self] autorelease];
    
    [self.cards addObject:card];
    [self.view addNewSprite: cardInfo
                    forCard: card];
  }
}

-(Card *) getCard:(NSInteger) cardNumber
{
  return [self.cards objectAtIndex:cardNumber];
}

-(void) readFlashCard
{
  Card *card = [self.cards objectAtIndex:[self.randomNumberGenerator next] % self.cards.count];
  
  [card makeCurrent];
}

-(void) correctGuess
{
  [self.view playCorrectSound];
}

-(void) incorrectGuess
{
  [self.view playInCorrectSound];
}

@end
