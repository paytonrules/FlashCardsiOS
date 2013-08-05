#import "FirstLesson.h"
#import "CardInfo.h"
#import "Card.h"

@interface FirstLesson()
@property(strong) NSArray *cardData;
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@property(strong) NSObject<GameView> *view;
@property(strong) NSMutableArray *cards;
@end

@implementation FirstLesson

- (id)init
{
    self = [super init];
    if (self) {
      self.cards = [NSMutableArray new];
    }
    return self;
}

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory> *)tableFactory
{
  return [self lessonWithSpriteTableFactory:tableFactory
                   andRandomNumberGenerator:nil];
}

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)generator
{
  FirstLesson *lesson = [[FirstLesson new] autorelease];
  lesson.cardData = [factory create];
  lesson.randomNumberGenerator = generator;
  
  return lesson;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  self.view = view;
  
  for (NSValue *cardInfoValue in self.cardData)
  {
    Card *card = [[Card new] autorelease];
    CardInfo cardInfo;
    [cardInfoValue getValue:&cardInfo];
    
    [self.cards addObject:card];
    [self.view addNewSprite: cardInfo.spriteName
                    forCard: card
                 atLocation: cardInfo.location];
    
  }
}

-(Card *) getCard:(NSInteger) cardNumber
{
  return [self.cards objectAtIndex:cardNumber];
  
}

-(void) readFlashCard
{
  Card *card = [self.cards objectAtIndex:[self.randomNumberGenerator next]];
  
  [card makeCurrent];
}

@end
