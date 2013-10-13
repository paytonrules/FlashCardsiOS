#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FlashCardsController.h"
#import "PlayClueCommand.h"
#import "Card.h"

OCDSpec2Context(FlashCardsControllerSpec) {
  
  Describe(@"Observing changes to the Flashcards", ^{
  
    __block id                    gameView;
    __block id                    lesson;
    __block Card                  *card;
    __block FlashCardsController  *cont;
    __block id                    mockPlayCue;
    
    BeforeEach(^{
      gameView = [OCMockObject mockForProtocol:@protocol(GameView)];
      lesson = [OCMockObject mockForProtocol:@protocol(Lesson)];
      card = [Card new];
      cont = [FlashCardsController flashCardsControllerWith:lesson view:gameView];
      mockPlayCue = [OCMockObject mockForClass:[PlayClueCommand class]];
    });
    
    AfterEach(^{
      [mockPlayCue stopMocking];
    });
    
    It(@"schedules a playClue when an observed card becomes current", ^{
      [[[lesson stub] andReturn:@[card]] cards];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView];
     
      [card makeCurrent];

      [cont update:0];
      
      [mockPlayCue verify];
    });

    It(@"only does it once for the given card", ^{
      [[[lesson stub] andReturn:@[card]] cards];
      
      [[mockPlayCue expect] commandWithCard:card view:gameView];
      [card makeCurrent];
      [cont update:0];
      
      [[mockPlayCue reject] commandWithCard:card view:gameView];
      [cont update:1];
      
      [mockPlayCue verify];
    });
    
    It(@"Schedules the playClue when the card switches", ^{
      Card *secondCard = [Card new];
      [[[lesson stub] andReturn:@[card, secondCard]] cards];

      [[mockPlayCue expect] commandWithCard:card view:gameView];
      [[mockPlayCue expect] commandWithCard:secondCard view:gameView];

      [card makeCurrent];
      [cont update:0];
      [card makeUnCurrent];
      [secondCard makeCurrent];
      [cont update:0];
      
      [mockPlayCue verify];
    });
  });
  
}
