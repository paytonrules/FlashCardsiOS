#import <OCDSpec2/OCDSpec2.h>
#import "Card.h"

OCDSpec2Context(CardSpec) {
  
  Describe(@"tapping the card", ^{
    
    It(@"lets the view know if the card is chosen", ^{
      Card *card = [Card cardWithView: view];
      
      
      [ExpectBool(NO) toBeTrue];
    });
    
    // Bounding box
    // Doesn't choose twice
    
  });
  
}
