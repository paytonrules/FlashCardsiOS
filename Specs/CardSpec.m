#import <OCDSpec2/OCDSpec2.h>
#import "OCMock.h"
#import "Card.h"
#import "CardView.h"

OCDSpec2Context(CardSpec) {
  
  Describe(@"tapping the card", ^{
    
    __block CGRect rect;
    __block id view;
    __block Card *card;
    
    BeforeEach(^{
      view = [OCMockObject mockForProtocol:@protocol(CardView)];
      card = [Card cardWithView: view];
    });
    
    It(@"lets the view know if the card is chosen correctly", ^{
      [[view expect] correct];
      
      [card makeCurrent];
      [card tap];
      
      [view verify];
    });
    
    It(@"says its incorrect if this is the wrong card", ^{
      [[view expect] incorrect];
      
      [card tap];
      
      [view verify];
    });
  });
  
}
