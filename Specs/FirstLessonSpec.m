#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "FirstLesson.h"

OCDSpec2Context(FirstLessonSpec) {
  
  Describe(@"The first lesson", ^{
    
    It(@"starts by creating a sprite from a card", ^{
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      CGPoint location = CGPointMake(0, 0);
      
      [[view expect] addNewSprite:@"huzzah"
                       atLocation:location];
      
      [FirstLesson startWithView:view];
      
      [view verify];
    });
    
  });
  
}
