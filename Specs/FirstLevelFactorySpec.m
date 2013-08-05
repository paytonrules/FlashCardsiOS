#import <OCDSpec2/OCDSpec2.h>
#import "FirstLevelFactory.h"
#import "CardInfo.h"

OCDSpec2Context(FirstLevelFactorySpec) {
  
  Describe(@"creating the first level", ^{
    
    It(@"creates three flashcards", ^{
      FirstLevelFactory *fact = [FirstLevelFactory new];
      
      [ExpectInt([[fact create] count]) toBe:3];
    });
    
    It(@"creates them as card info", ^{
      FirstLevelFactory *fact = [FirstLevelFactory new];
      NSArray *cards = [fact create];
      
      NSValue *rawCardInfo = [cards objectAtIndex:0];
      CardInfo cardInfo;
      [rawCardInfo getValue:&cardInfo];
      
      [ExpectStr(cardInfo.spriteName) toContain:@".png"];
    });
    
  });
  
}
