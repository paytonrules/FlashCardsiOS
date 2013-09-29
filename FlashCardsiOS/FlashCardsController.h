#import <Foundation/Foundation.h>
#import "GameView.h"
#import "cocos2d.h"

@interface FlashCardsController : CCNode {
    
}
+(id) contWith:(NSMutableArray *)cards andView:(NSObject<GameView> *) gameView;

@end
