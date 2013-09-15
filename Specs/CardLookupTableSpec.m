#import <OCDSpec2/OCDSpec2.h>
#import "CardLookupTable.h"

OCDSpec2Context(CardLookupTable) {
  
  Describe(@"creating card info structures", ^{
    
    It(@"creates a card info structure", ^{
      CardLookupTable *info = [CardLookupTable cardInfoWithName:@"name"
                                        reading:@"reading"
                                     atLocation:CGPointMake(0, 1)];
      
      [ExpectInt(info.location.x) toBe:0];
      [ExpectInt(info.location.y) toBe:1];
      [ExpectStr(info.spriteName) toContain:@"name"];
      [ExpectStr(info.reading) toContain:@"reading"];
    });
    
    It("it returns location information for a card", ^{
      
    });
    
  });
  
}
