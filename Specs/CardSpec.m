#import <OCDSpec2/OCDSpec2.h>
#import "OCMock.h"
#import "Card.h"
#import "CardView.h"

OCDSpec2Context(CardSpec) {
  
  Describe(@"tapping the card", ^{
    
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
  
  Describe(@"Containing a point", ^{
    __block id view;
    __block Card *card;
    __block CGSize textureSize;
    
    BeforeEach(^{
      textureSize = CGSizeMake(10, 10);
      view = [OCMockObject mockForProtocol:@protocol(CardView)];
      [[[view stub] andReturnValue:OCMOCK_VALUE(textureSize)] textureSize];
      card = [Card cardWithView: view];
    });
    
    It(@"returns true if the point is in the texture box", ^{
      [ExpectBool([card contains:CGPointMake(0, 0)]) toBeTrue];
    });
    
    It(@"returns false if the point is past the left-most x-coord in node space", ^{
      [ExpectBool([card contains:CGPointMake(-5, 0)]) toBeTrue];
      [ExpectBool([card contains:CGPointMake(-6, 0)]) toBeFalse];
    });
    
    It(@"returns false if the point is past the right-most x-coord in node space", ^{
      [ExpectBool([card contains:CGPointMake(4, 0)]) toBeTrue];
      [ExpectBool([card contains:CGPointMake(5, 0)]) toBeFalse];
    });
    
    It(@"returns false if the point is past the top most coord in node space", ^{
      [ExpectBool([card contains:CGPointMake(0, -5)]) toBeTrue];
      [ExpectBool([card contains:CGPointMake(0, -6)]) toBeFalse];
    });
    
    It(@"returns false if the point is past the bottom most coord in node space", ^{
      [ExpectBool([card contains:CGPointMake(0, 4)]) toBeTrue];
      [ExpectBool([card contains:CGPointMake(0, 5)]) toBeFalse];
    });
  });
}
