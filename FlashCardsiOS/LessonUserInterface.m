#import "LessonUserInterface.h"
#import "PlayClueCommand.h"
#import "Card.h"
#import "SchedulerWrapper.h"

@interface LessonUserInterface()
@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<GameView> *view;
@property(strong) Card* currentCard;
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
  }
  return self;
}

-(void) startLesson
{
  [self.lesson start];
}

-(void) playIntroduction
{
  [self.view showIntroduction];
}

-(void) update:(ccTime)delta
{
  if (self.currentCard != self.lesson.currentCard) {
    self.currentCard = self.lesson.currentCard;
    [PlayClueCommand commandWithCard:self.lesson.currentCard
                                view:self.view
                           scheduler:[SchedulerWrapper schedulerWrapperWithCocosScheduler:self.scheduler]];
  }
  [self.lesson update];
}



@end
