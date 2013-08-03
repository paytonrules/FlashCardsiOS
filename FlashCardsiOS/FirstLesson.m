#import "FirstLesson.h"
#import "CardInfo.h"

@interface FirstLesson()
@property(strong) NSArray *spriteTable;
@property(strong) NSObject<RandomNumberGenerator> *randomNumberGenerator;
@end

@implementation FirstLesson

// Table
// Random number generator
// View

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

+(id) startWithView:(NSObject<GameView> *)view
{
  [view addNewSprite: @"huzzah"
             forCard: [NSObject new]
          atLocation: CGPointMake(0, 0)];
  return nil;
}


@end
