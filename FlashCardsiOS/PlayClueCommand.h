#import "CCNode.h"
#import "GameView.h"
#import "Scheduler.h"

@class Card;

@interface PlayClueCommand : NSObject

+(id) commandWithCard:(Card *) card view:(NSObject<GameView> *)view;
+(id) commandWithCard:(Card *) card view:(NSObject<GameView> *)view scheduler:(NSObject<Scheduler> *)sched;


@end
