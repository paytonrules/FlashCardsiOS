#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "SchedulerWrapper.h"
#import "LessonUserInterface.h"
#import "PlayClueCommand.h"
#import "Card.h"

OCDSpec2Context(LessonUserInterfaceSpec){
  
  Describe(@"Observing changes to the Lesson", ^{
  
    __block id                    gameView;
    __block id                    lesson;
    __block Card                  *card;
    __block LessonUserInterface  *cont;
    __block id                    mockPlayCue;
    
    BeforeEach(^{
      gameView = [OCMockObject mockForProtocol:@protocol(GameView)];
      lesson = [OCMockObject mockForProtocol:@protocol(Lesson)];
      card = [Card new];
      cont = [LessonUserInterface flashCardsControllerWith:lesson view:gameView];
      mockPlayCue = [OCMockObject mockForClass:[PlayClueCommand class]];
    });
    
    AfterEach(^{
      [mockPlayCue stopMocking];
    });
    
    It(@"schedules a playClue when a new card becomes current", ^{
      [[lesson stub] update];
      [[[lesson stub] andReturn:@[]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      
      [card makeCurrent];

      [cont update:0];
      
      [mockPlayCue verify];
    });

    It(@"only does it once for the given card", ^{
      [[lesson stub] update];
      [[[lesson stub] andReturn:@[card]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      [card makeCurrent];
      [cont update:0];
      
      [[mockPlayCue reject] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      [cont update:1];
      
      [mockPlayCue verify];
    });

    It(@"creates a schedule wrapper with its scheduler", ^{
      [[lesson stub] update];
      [[[lesson stub] andReturn:@[card]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:[OCMArg any]
                                       view:[OCMArg any]
                                  scheduler:[OCMArg checkWithBlock:^BOOL(id obj) {
        SchedulerWrapper *wrapper = (SchedulerWrapper *) obj;
        
        return wrapper.scheduler == cont.scheduler;
      }]];
      
      [card makeCurrent];
      
      [cont update:0];
      
      [mockPlayCue verify];
    });
    
    It(@"updates the lesson controller each update", ^{
      [[[lesson stub] andReturn:nil] currentCard];
      [[lesson expect] update];
      
      [cont update:0];
      
      [lesson verify];
    });
  });
  
}
