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
      rect = CGRectMake(0, 0, 10, 10);
      view = [OCMockObject mockForProtocol:@protocol(CardView)];
      [[[view stub] andReturnValue: OCMOCK_VALUE(rect)] boundingBox];
      card = [Card cardWithView: view];
    });
    
    It(@"lets the view know if the card is chosen correctly", ^{
      [[view expect] correct];
      
      [card makeCurrent];
      [card tap:CGPointMake(1, 1)];
      
      [view verify];
    });
    
    It(@"says its incorrect if this is the wrong card", ^{
      [[view expect] incorrect];
      
      [card tap:CGPointMake(1, 1)];
      
      [view verify];
    });
    
    It(@"doesnt say its chosen correctly or incorrectly if the tap is not in the bounding box", ^{
      [[view reject] correct];
      [[view reject] incorrect];
      
      [card makeCurrent];
      [card tap:CGPointMake(11, 11)];
      
      [view verify];
    });

  });
  
}
