#import "LessonController.h"
#import "PlayClueCommand.h"
#import "Card.h"
#import "SchedulerWrapper.h"

@interface LessonController()
@property(strong) NSObject<Lesson> *lesson;
@property(strong) NSObject<GameView> *view;
@property(strong) Card* currentCard;
@end

@implementation LessonController

+(id) flashCardsControllerWith:(NSObject<Lesson>*) lesson view:(NSObject<GameView> *) view
{
  return [[LessonController alloc] initWithLesson:lesson view:view];
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
  if (self.currentCard != self.lesson.currentCard) {
    self.currentCard = self.lesson.currentCard;
    [PlayClueCommand commandWithCard:self.lesson.currentCard
                                view:self.view
                           scheduler:[SchedulerWrapper schedulerWrapperWithCocosScheduler:self.scheduler]];
  }
}



@end
