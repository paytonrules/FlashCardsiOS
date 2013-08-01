#import <OCDSpec2/OCDSpec2.h>
#import "Card.h"

OCDSpec2Context(CardSpec) {
  
  Describe(@"-someBehavior", ^{
    
    It(@"fails", ^{
      [ExpectBool(NO) toBeTrue];
    });
    
  });
  
}
