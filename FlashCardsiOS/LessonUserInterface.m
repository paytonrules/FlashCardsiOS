#import "LessonUserInterface.h"
#import "PlayClueCommand.h"
#import "Card.h"
#import "SchedulerWrapper.h"

@interface LessonUserInterface()
@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<GameView> *view;
@property(strong) Card* currentCard;
@property(assign) BOOL loadedCards;
@end

@implementation LessonUserInterface

+(id) flashCardsControllerWith:(NSObject<Lesson>*) lesson view:(NSObject<GameView> *) view
{
  return [[LessonUserInterface alloc] initWithLesson:lesson view:view];
}

-(id) initWithLesson:(NSObject<Lesson> *) lesson view:(NSObject<GameView> *)view
{
  self = [super init];
  if (self) {
    self.lesson = lesson;
    self.view = view;
    self.loadedCards = NO;
  }
  return self;
}

-(void) startLesson
{
  [self.view showIntroduction:self];
}

-(void) introductionComplete
{
  [self.lesson start];
}

-(void) update:(ccTime)delta
{
  if (self.lesson.started && !self.loadedCards) {
    for (Card *card in [self.lesson cards])
    {
      [self.view addCard:card];
    }
    self.loadedCards = YES;
  }
  
  if (self.currentCard != self.lesson.currentCard) {
    self.currentCard = self.lesson.currentCard;
    [PlayClueCommand commandWithCard:self.lesson.currentCard
                                view:self.view
                           scheduler:[SchedulerWrapper schedulerWrapperWithCocosScheduler:self.scheduler]];
  }
  [self.lesson update];
}



@end
