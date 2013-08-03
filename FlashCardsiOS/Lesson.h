#import <Foundation/Foundation.h>
#import "GameView.h"

@protocol Lesson <NSObject>

+(id) startWithView:(NSObject<GameView> *)view;

@end
