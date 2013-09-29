#import "FlashCardsController.h"


@implementation FlashCardsController

+(id) contWith:(NSMutableArray *)cards andView:(NSObject<GameView> *)gameView
{
  return [[FlashCardsController alloc] initWithCards:cards];
}

-(id) initWithCards:(NSMutableArray *) cards
{
  self = [super init];
  if (self) {
  }
  return self;
}


@end
