#import "PlayClueCommand.h"
#import "Card.h"

@interface PlayClueCommand()

@property(strong) Card *card;
@property(strong) NSObject<GameView> *view;
@property(strong) NSObject<Scheduler> *scheduler;

@end

@implementation PlayClueCommand

+(id) commandWithCard:(Card *) card view:(NSObject<GameView> *)view
{
  return [[PlayClueCommand alloc] initWithCard:card view:view scheduler:nil];
}

+(id) commandWithCard:(Card *) card view:(NSObject<GameView> *)view scheduler:(NSObject<Scheduler> *)sched
{
  return [[PlayClueCommand alloc] initWithCard:card view:view scheduler:sched];
}

-(id) initWithCard:(Card *) card view:(NSObject<GameView> *)view scheduler:(NSObject<Scheduler> *)sched
{
    self = [super init];
    if (self) {
      self.card = card;
      self.view = view;
      self.scheduler = sched;
      [self.scheduler scheduleOnce: self action: @selector(playClue:) delay:1];
   //   [self scheduleOnce:@selector(playClue:) delay:1];
    }
    return self;
}

-(void) playClue:(ccTime) delta
{
  NSLog(@"THAT'S THE RULE");
  [self.view playClue:self.card];
}

@end
