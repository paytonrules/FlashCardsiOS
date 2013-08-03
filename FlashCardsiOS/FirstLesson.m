#import "FirstLesson.h"

@implementation FirstLesson

// Table
// Random number generator
// View

+(id) lessonWithSpriteTableFactory:(NSObject<TableFactory> *) factory andRandomNumberGenerator:(NSObject<RandomNumberGenerator> *)generator
{
  FirstLesson *lesson = [[FirstLesson new] autorelease];
  
  return lesson;
}

-(void) startWithView:(NSObject<GameView> *)view
{
  [view addNewSprite: @"huzzah"
             forCard: [NSObject new]
          atLocation: CGPointMake(0, 0)];
}

+(id) startWithView:(NSObject<GameView> *)view
{
  [view addNewSprite: @"huzzah"
             forCard: [NSObject new]
          atLocation: CGPointMake(0, 0)];
  return nil;
}


@end
