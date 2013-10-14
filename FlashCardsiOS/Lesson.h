#import <Foundation/Foundation.h>
#import "GameView.h"

@protocol Lesson <NSObject>

-(void) startWithView:(NSObject<GameView> *)view;
-(void) correctGuess;
-(void) incorrectGuess;
-(void) update;
@property(readonly) NSMutableArray *cards;
@property(readonly) Card *currentCard;

@end
