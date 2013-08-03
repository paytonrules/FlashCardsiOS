// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameView.h"

// HelloWorldLayer
@interface FlashCards : CCLayer<GameView>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
