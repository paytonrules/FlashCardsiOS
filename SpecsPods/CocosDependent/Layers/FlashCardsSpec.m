#import <OCDSpec2/OCDSpec2.h>
#import "FlashCards.h"

OCDSpec2Context(FlashCardsSpec) {
  
  Describe(@"Observing changes to the Flashcards", ^{
    
    It(@"schedules a playClue when an observed card becomes current", ^{
      FlashCards *cards = [FlashCards sceneWithLesson:nil spriteLookup:nil];
    });
    
  });
  
}
