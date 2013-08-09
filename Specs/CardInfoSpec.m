#import <OCDSpec2/OCDSpec2.h>
#import "CardInfo.h"

OCDSpec2Context(CardInfoSpec) {
  
  Describe(@"creating card info structures", ^{
    __block CardInfo *info;
    
    BeforeEach(^{
      info = NULL;
    });
    
    AfterEach(^{
      if (info != NULL)
      {
        free(info);
      }
    });
    
    It(@"creates a card info structure", ^{
      CardInfo *info = [CardInfo cardInfoWithName:@"name"
                                        reading:@"reading"
                                     atLocation:CGPointMake(0, 1)];
      
      [ExpectInt(info.location.x) toBe:0];
      [ExpectInt(info.location.y) toBe:1];
      [ExpectStr(info.spriteName) toContain:@"name"];
      [ExpectStr(info.reading) toContain:@"reading"];
    });
    
  });
  
}
