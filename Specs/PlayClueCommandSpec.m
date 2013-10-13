#import <OCDSpec2/OCDSpec2.h>
#import <OCMock/OCMock.h>
#import "Card.h"
#import "PlayClueCommand.h"
#import "Scheduler.h"

@interface SimpleEvent : NSObject

@property(strong) id target;
@property(assign) SEL action;
@property(assign) BOOL once;
@property(assign) float delay;

@end

@implementation SimpleEvent

@end

@interface FakeScheduler : NSObject<Scheduler>

@property(strong) NSMutableArray *events;

@end

@implementation FakeScheduler

-(id) init
{
    self = [super init];
    if (self) {
      self.events = [NSMutableArray new];
    }
    return self;
}

-(void) scheduleOnce:(id) target action:(SEL) selector delay:(ccTime)delay
{
  SimpleEvent *evt = [SimpleEvent new];
  evt.target = target;
  evt.action = selector;
  evt.once = YES;
  evt.delay = delay;
  [self.events addObject:evt];
}

-(void) update:(float) time
{
  for (SimpleEvent *event in self.events) {
    if (time >= event.delay) {
      #pragma clang diagnostic push
      #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [event.target performSelector: event.action];
      #pragma clang diagnostic pop
      
      
      if (event.once) {
        [self.events removeObject:event];
      }
    }
  }
}

@end

OCDSpec2Context(PlayClueCommandSpec) {
  
  Describe(@"Scheduling the Clue", ^{
    
    It(@"schedules the play clue command one second later", ^{
      id card = [Card new];
      id view = [OCMockObject mockForProtocol:@protocol(GameView)];
      FakeScheduler *scheduler = [FakeScheduler new];
      [PlayClueCommand commandWithCard:card view:view scheduler:scheduler];

      [[view expect] playClue:card];
      
      [scheduler update:1];
      
      [view verify];
    });
    
  });
  
}
