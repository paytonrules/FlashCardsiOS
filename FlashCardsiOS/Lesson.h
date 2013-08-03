#import <Foundation/Foundation.h>
#import "GameView.h"

@protocol Lesson <NSObject>

-(void) startWithView:(NSObject<GameView> *)view;

@end
