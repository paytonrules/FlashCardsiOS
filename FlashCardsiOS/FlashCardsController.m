#import "FlashCardsController.h"
#import "PlayClueCommand.h"
#import "Card.h"

@interface FlashCardsController()
@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<GameView> *view;
@property(strong) Card* currentCard;
@end

@implementation FlashCardsController

+(id) flashCardsControllerWith:(NSObject<Lesson>*) lesson view:(NSObject<GameView> *) view
{
  return [[FlashCardsController alloc] initWithLesson:lesson view:view];
}

-(id) initWithLesson:(NSObject<Lesson> *) lesson view:(NSObject<GameView> *)view
{
  self = [super init];
  if (self) {
    self.lesson = lesson;
    self.view = view;
  }
  return self;
}

-(void) update:(ccTime)delta
{
  for (Card *card in self.lesson.cards) {
    if (card.current && self.currentCard != card) {
      self.currentCard = card;
      [PlayClueCommand commandWithCard:card view:self.view];
      break;
    }
  }
}
/*
-(void) playClue:(Card *) card
{
  [self.view playClue:card];
}*/


@end
