#import <OCDSpec2/OCDSpec2.h>
#import "OCMock.h"
#import "Card.h"
#import "Lesson.h"

OCDSpec2Context(CardSpec) {
  
  Describe(@"Creation", ^{

    It(@"requires a name", ^{
      Card *card = [[[Card alloc] initWithName:@"name"] autorelease];
      
      [ExpectBool(card.current) toBeFalse];
      [ExpectObj(card.name) toBe:@"name"];
    });

    It(@"optionally has a view", ^{
      id lesson = [OCMockObject mockForProtocol:@protocol(Lesson)];
      Card *card = [[[Card alloc] initWithName:@"name" lesson:lesson] autorelease];
      
      [ExpectBool(card.current) toBeFalse];
      [ExpectObj(card.name) toBe:@"name"];
      [ExpectObj(card.lesson) toBe:lesson];
    });
  });
  
  Describe(@"tapping the card", ^{
    
    __block id lesson;
    __block Card *card;
    
    BeforeEach(^{
      lesson = [OCMockObject mockForProtocol:@protocol(Lesson)];
      card = [Card cardWithName: @"" lesson:lesson];
    });
    
    It(@"lets the lesson know if the card is chosen correctly", ^{
      [[lesson expect] correctGuess];
      
      [card makeCurrent];
      [card tap];
      
      [lesson verify];
    });
    
    It(@"lets the lesson know about an incorrect guess if this is the wrong card", ^{
      [[lesson expect] incorrectGuess];
      
      [card tap];
      
      [lesson verify];
    });
  });
  
  Describe(@"Making the card current", ^{

    It(@"makes the card curent", ^{
      Card *card = [Card cardWithName: @"" lesson:nil];
      [ExpectBool(card.current) toBeFalse];

      [card makeCurrent];

      [ExpectBool(card.current) toBeTrue];
    });

  });

  Describe(@"Checking if a card contains a point", ^{
    __block CGSize textureSize;
    
    BeforeEach(^{
      textureSize = CGSizeMake(10, 10);
    });
    
    It(@"returns true if the point is in the texture box", ^{
      [ExpectBool([Card contains:CGPointMake(0, 0) inTextureSize:textureSize]) toBeTrue];
    });
    
    It(@"returns false if the point is past the left-most x-coord in node space", ^{
      [ExpectBool([Card contains:CGPointMake(-5, 0) inTextureSize:textureSize]) toBeTrue];
      [ExpectBool([Card contains:CGPointMake(-6, 0) inTextureSize:textureSize]) toBeFalse];
    });
    
    It(@"returns false if the point is past the right-most x-coord in node space", ^{
      [ExpectBool([Card contains:CGPointMake(4, 0) inTextureSize:textureSize]) toBeTrue];
      [ExpectBool([Card contains:CGPointMake(5, 0) inTextureSize:textureSize]) toBeFalse];
    });
    
    It(@"returns false if the point is past the top most coord in node space", ^{
      [ExpectBool([Card contains:CGPointMake(0, -5) inTextureSize:textureSize]) toBeTrue];
      [ExpectBool([Card contains:CGPointMake(0, -6) inTextureSize:textureSize]) toBeFalse];
    });
    
    It(@"returns false if the point is past the bottom most coord in node space", ^{
      [ExpectBool([Card contains:CGPointMake(0, 4) inTextureSize:textureSize]) toBeTrue];
      [ExpectBool([Card contains:CGPointMake(0, 5) inTextureSize:textureSize]) toBeFalse];
    });
  });
}
