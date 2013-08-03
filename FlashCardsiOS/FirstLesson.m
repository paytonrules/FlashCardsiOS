#import "FirstLesson.h"
#import "CardInfo.h"

@interface FirstLesson()
@property(strong) NSArray *spriteTable;
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@end

@implementation FirstLesson

+(id) lessonWithSpriteTableFactory:(NSObject<SpriteTableLookupFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)generator
{
  FirstLesson *lesson = [[FirstLesson new] autorelease];
  lesson.spriteTable = [factory create];
  lesson.randomNumberGenerator = generator;
  
  return lesson;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  NSValue *cardInfoValue = [self.spriteTable objectAtIndex:[self.randomNumberGenerator next]];
  CardInfo cardInfo;
  [cardInfoValue getValue:&cardInfo];
  
  [view addNewSprite: cardInfo.spriteName
             forCard: [NSObject new]
          atLocation: cardInfo.location];
}

@end
