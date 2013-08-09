#import <OCDSpec2/OCDSpec2.h>
#import "FirstLevelFactory.h"
#import "CardInfo.h"

OCDSpec2Context(FirstLevelFactorySpec) {
  
  Describe(@"creating the first level", ^{
    
    It(@"creates three flashcards", ^{
      FirstLevelFactory *fact = [[FirstLevelFactory new] autorelease];
      
      [ExpectInt([[fact create] count]) toBe:3];
    });
    
    It(@"creates them as card info", ^{
      FirstLevelFactory *fact = [[FirstLevelFactory new] autorelease];
      NSArray *cards = [fact create];
      
      CardInfo *cardInfo = [cards objectAtIndex:0];
      
      [ExpectStr(cardInfo.spriteName) toContain:@".png"];
    });
    
  });
  
}
