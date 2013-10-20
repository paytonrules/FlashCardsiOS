#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "SchedulerWrapper.h"
#import "LessonUserInterface.h"
#import "PlayClueCommand.h"
#import "Card.h"
#import "Lesson.h"

OCDSpec2Context(LessonUserInterfaceSpec){
  
  Describe(@"Observing changes to the Lesson", ^{
  
    __block id                    gameView;
    __block id                    lesson;
    __block Card                  *card;
    __block LessonUserInterface  *ui;
    __block id                    mockPlayCue;
    
    BeforeEach(^{
      gameView = [OCMockObject niceMockForProtocol:@protocol(GameView)];
      lesson = [OCMockObject mockForProtocol:@protocol(Lesson)];
      card = [Card new];
      ui = [LessonUserInterface flashCardsControllerWith:lesson view:gameView];
      mockPlayCue = [OCMockObject mockForClass:[PlayClueCommand class]];
    });
    
    AfterEach(^{
      [mockPlayCue stopMocking];
    });
    
    It(@"tells the view to show the introduction on start - passing itself as the delegate", ^{
      [[gameView expect] showIntroduction:ui];
      
      [ui startLesson];
      
      [lesson verify];
    });
    
    It(@"starts the lesson when the introduction is complete", ^{
      [(NSObject<Lesson> *)[lesson expect] start];
      
      [ui introductionComplete];
      
      [lesson verify];
    });
    
    It(@"schedules a playClue when a new card becomes current", ^{
      [[lesson stub] started];
      [[lesson stub] update];
      [[[lesson stub] andReturn:@[]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      
      [card makeCurrent];

      [ui update:0];
      
      [mockPlayCue verify];
    });

    It(@"only does it once for the given card", ^{
      [[lesson stub] started];
      [[lesson stub] update];
      [[[lesson stub] andReturn:@[card]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      [card makeCurrent];
      [ui update:0];
      
      [[mockPlayCue reject] commandWithCard:card view:gameView scheduler:[OCMArg any]];
      [ui update:1];
      
      [mockPlayCue verify];
    });

    It(@"creates a schedule wrapper with its scheduler", ^{
      [[lesson stub] update];
      [[lesson stub] started];
      [[[lesson stub] andReturn:@[card]] cards];
      [[[lesson stub] andReturn:card] currentCard];
      
      [[mockPlayCue expect] commandWithCard:[OCMArg any]
                                       view:[OCMArg any]
                                  scheduler:[OCMArg checkWithBlock:^BOOL(id obj) {
        SchedulerWrapper *wrapper = (SchedulerWrapper *) obj;
        
        return wrapper.scheduler == ui.scheduler;
      }]];
      
      [card makeCurrent];
      
      [ui update:0];
      
      [mockPlayCue verify];
    });
    
    It(@"creates views for each card on the first update", ^{
      Card *cardOne = [Card new];
      Card *cardTwo = [Card new];
      [lesson setExpectationOrderMatters:YES];
      [[[lesson stub] andReturnValue:OCMOCK_VALUE((BOOL) {YES})] started];
      [[[lesson expect] andReturn:@[cardOne, cardTwo]] cards];
      [[lesson stub] currentCard];
      [[lesson stub] update];
      
      [[gameView expect] addCard:cardOne];
      [[gameView expect] addCard:cardTwo];
      
      [ui update:0];
      
      [lesson verify];
      [gameView verify];
    });
    
    It(@"only creates the views once", ^{
      Card *cardOne = [Card new];
      Card *cardTwo = [Card new];

      [lesson setExpectationOrderMatters:YES];
      [[[lesson stub] andReturnValue:OCMOCK_VALUE((BOOL) {YES})] started];
      [[[lesson stub] andReturn:@[cardOne, cardTwo]] cards];
      [[lesson stub] currentCard];
      [[lesson stub] update];
      
      [[gameView expect] addCard:cardOne];
      [[gameView expect] addCard:cardTwo];
      
      [ui update:0];
      [ui update:0];
      
      [lesson verify];
      [gameView verify];
    });

    It(@"doesn't update if lesson isn't started", ^{
      [[lesson stub] update];
      [[lesson stub] currentCard];
      [[[lesson stub] andReturnValue:OCMOCK_VALUE((BOOL) {NO})] started];

      [ui update:0];
      
      [lesson verify];
      [gameView verify];
    });
    
    It(@"updates the lesson each update", ^{
      [[lesson stub] started];
      [[[lesson stub] andReturn:nil] currentCard];
      [[lesson expect] update];
      
      [ui update:0];
      
      [lesson verify];
    });
  });
  
}
