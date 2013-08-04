#import "FirstLesson.h"
#import "CardInfo.h"
#import "Card.h"

@interface FirstLesson()
@property(strong) NSArray *spriteTable;
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@property(strong) NSObject<GameView> *view;
@end

@implementation FirstLesson

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory> *)tableFactory
{
  return [self lessonWithSpriteTableFactory:tableFactory
                   andRandomNumberGenerator:nil];
}

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)generator
{
  FirstLesson *lesson = [[FirstLesson new] autorelease];
  lesson.spriteTable = [factory create];
  lesson.randomNumberGenerator = generator;
  
  return lesson;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  self.view = view;
  
  for (NSValue *cardInfoValue in self.spriteTable)
  {
    CardInfo cardInfo;
    [cardInfoValue getValue:&cardInfo];
    
    [self.view addNewSprite: cardInfo.spriteName
                    forCard: [Card new]
                 atLocation: cardInfo.location];
    
  }
}

-(void) addCard
{
  NSValue *cardInfoValue = [self.spriteTable objectAtIndex:[self.randomNumberGenerator next]];
  CardInfo cardInfo;
  [cardInfoValue getValue:&cardInfo];
  
  [self.view addNewSprite: cardInfo.spriteName
             forCard: [NSObject new]
          atLocation: cardInfo.location];
}

@end
