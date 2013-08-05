#import <Foundation/Foundation.h>
#import "GameView.h"

@protocol Lesson <NSObject>

-(void) startWithView:(NSObject<GameView> *)view;
-(void) readFlashCard;
-(void) correctGuess;
-(void) incorrectGuess;

@end
