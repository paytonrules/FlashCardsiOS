#import "FirstLesson.h"

@implementation FirstLesson

+(id) startWithView:(NSObject<GameView> *)view
{
  [view addNewSprite:@"huzzah" atLocation:CGPointMake(0, 0)];
  return nil;
}


@end
